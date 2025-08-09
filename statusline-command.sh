#!/bin/bash

# Claude Code Status Line Script
# Displays: Live Date | Git Branch | Current Model | Session Cost | Daily Usage % | Session Remaining Time

# Color definitions (256-color palette for smooth appearance)
COLOR_RESET="\033[0m"
COLOR_DATETIME="\033[38;5;250m"  # Light gray
COLOR_BRANCH="\033[38;5;114m"    # Soft green
COLOR_MODEL="\033[38;5;141m"     # Soft purple
COLOR_COST="\033[38;5;215m"      # Soft orange

# Remaining time color coding:
# - Cyan: More than 1 hour remaining (comfortable buffer)
# - Yellow: Less than 1 hour remaining (warning to wrap up)
# - Red: Block expired or error
COLOR_TIME_NORMAL="\033[38;5;117m" # Soft cyan (>1hr remaining)
COLOR_TIME_WARNING="\033[38;5;221m" # Soft yellow (<1hr remaining)
COLOR_TIME_ERROR="\033[38;5;210m"  # Soft red (expired/error)

COLOR_SEPARATOR="\033[38;5;240m"   # Dark gray
COLOR_MUTED="\033[38;5;245m"       # Medium gray for inactive states

# Daily usage percentage color coding:
# - Green: < 80% of daily budget (well under budget)
# - Yellow: 80-120% of daily budget (near or slightly over budget)
# - Orange: 120-150% of daily budget (significantly over budget)
# - Red: > 150% of daily budget (critically over budget)
COLOR_PERCENT_GOOD="\033[38;5;114m"   # Green for under budget (<80%)
COLOR_PERCENT_WARN="\033[38;5;221m"   # Yellow for near budget (80-120%)
COLOR_PERCENT_OVER="\033[38;5;215m"   # Orange for over budget (120-150%)
COLOR_PERCENT_HIGH="\033[38;5;210m"   # Red for significantly over (>150%)

# Read JSON input from stdin
input=$(cat)

# Extract information from JSON input
model_raw=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
model="${COLOR_MODEL}${model_raw}${COLOR_RESET}"
cwd=$(echo "$input" | jq -r '.workspace.current_dir // "."')

# Change to working directory to get git info
cd "$cwd" 2>/dev/null

# Get current git branch
branch_raw=$(git symbolic-ref --short HEAD 2>/dev/null || echo "no git")
# Apply color based on git status
if [ "$branch_raw" = "no git" ]; then
    branch="${COLOR_MUTED}${branch_raw}${COLOR_RESET}"
else
    branch="${COLOR_BRANCH}${branch_raw}${COLOR_RESET}"
fi

# Get current date and time
datetime_raw=$(date '+%Y-%m-%d %H:%M:%S')
datetime="${COLOR_DATETIME}${datetime_raw}${COLOR_RESET}"

# Get Claude Code session information
session_cost_raw="no session"
remaining_time_raw="no block"
time_color="$COLOR_MUTED"
daily_usage_raw="N/A"
usage_color="$COLOR_MUTED"

if command -v ccstat >/dev/null 2>&1; then
    # Try to get active block from ccstat
    block_data=$(ccstat blocks --active --json --quiet 2>/dev/null)
    
    if [ -n "$block_data" ]; then
        # Extract session cost
        cost_value=$(echo "$block_data" | jq -r '.blocks[0].total_cost // null' 2>/dev/null)
        if [ "$cost_value" != "null" ] && [ -n "$cost_value" ]; then
            session_cost_raw=$(printf "$%.2f" "$cost_value")
        fi
        
        # Calculate remaining time based on 5-hour aligned blocks
        # Claude Code uses 5-hour billing periods aligned to UTC hours (0:00, 5:00, 10:00, 15:00, 20:00)
        
        # Get current UTC time
        current_utc_hour=$(date -u '+%H')
        current_utc_date=$(date -u '+%Y-%m-%d')
        current_epoch=$(date "+%s")
        
        # Calculate the next 5-hour boundary
        # Formula: next_block_hour = ((current_hour / 5) + 1) * 5
        next_block_hour=$(( (current_utc_hour / 5 + 1) * 5 ))
        
        # Handle wraparound at 24:00 (becomes 00:00 next day)
        if [ "$next_block_hour" -ge 24 ]; then
            next_block_hour=$((next_block_hour - 24))
            # Add one day to the date
            end_date=$(date -u -v+1d '+%Y-%m-%d' 2>/dev/null || date -u -d "+1 day" '+%Y-%m-%d' 2>/dev/null)
        else
            end_date="$current_utc_date"
        fi
        
        # Format the end time
        end_time_formatted=$(printf "%s %02d:00:00" "$end_date" "$next_block_hour")
        
        # Convert to epoch - try macOS date first, then GNU date
        end_epoch=$(date -j -u -f "%Y-%m-%d %H:%M:%S" "$end_time_formatted" "+%s" 2>/dev/null || date -u -d "$end_time_formatted" "+%s" 2>/dev/null)
        
        if [ -n "$end_epoch" ] && [ -n "$current_epoch" ]; then
            remaining_seconds=$((end_epoch - current_epoch))
            if [ "$remaining_seconds" -gt 0 ]; then
                remaining_minutes=$((remaining_seconds / 60))
                
                if [ "$remaining_minutes" -lt 60 ]; then
                    remaining_time_raw="${remaining_minutes}m left"
                    time_color="$COLOR_TIME_WARNING"
                else
                    hours=$((remaining_minutes / 60))
                    minutes=$((remaining_minutes % 60))
                    remaining_time_raw="${hours}h ${minutes}m left"
                    time_color="$COLOR_TIME_NORMAL"
                fi
            else
                remaining_time_raw="expired"
                time_color="$COLOR_TIME_ERROR"
            fi
        else
            remaining_time_raw="time error"
            time_color="$COLOR_TIME_ERROR"
        fi
        
        # Calculate daily usage percentage
        # This shows how much of your daily budget you've used today
        # Formula: (today's total cost / daily budget) * 100
        # Where daily budget = $200 / days_in_current_month
        
        # Get today's cost from ccstat daily
        today_cost=$(ccstat daily --json --quiet 2>/dev/null | jq -r '.daily[-1].total_cost // 0' 2>/dev/null)
        
        if [ -n "$today_cost" ] && [ "$today_cost" != "0" ]; then
            # Calculate days in current month using cal command
            days_in_month=$(cal $(date '+%m %Y') 2>/dev/null | awk 'NF {DAYS=$NF} END {print DAYS}')
            
            if [ -n "$days_in_month" ] && [ "$days_in_month" -gt 0 ]; then
                # Calculate daily budget
                # Formula: $200 monthly budget / days_in_month
                # Example: August has 31 days, so daily budget = $200/31 = $6.45
                daily_budget=$(echo "scale=2; 200 / $days_in_month" | bc 2>/dev/null)
                
                if [ -n "$daily_budget" ]; then
                    # Calculate usage percentage
                    # Formula: (today_cost / daily_budget) * 100
                    # Example: If today_cost=$10 and daily_budget=$6.45, then usage=155%
                    usage_percent=$(echo "scale=1; ($today_cost / $daily_budget) * 100" | bc 2>/dev/null)
                    
                    if [ -n "$usage_percent" ]; then
                        daily_usage_raw="${usage_percent}%"
                        
                        # Apply color based on percentage thresholds
                        # Remove decimal part for comparison
                        percent_int=${usage_percent%.*}
                        
                        if [ "$percent_int" -lt 80 ]; then
                            # Under 80%: Good - well within daily budget
                            usage_color="$COLOR_PERCENT_GOOD"
                        elif [ "$percent_int" -lt 120 ]; then
                            # 80-120%: Warning - approaching or slightly over budget
                            usage_color="$COLOR_PERCENT_WARN"
                        elif [ "$percent_int" -lt 150 ]; then
                            # 120-150%: Over - significantly exceeding budget
                            usage_color="$COLOR_PERCENT_OVER"
                        else
                            # Over 150%: Critical - far exceeding budget
                            usage_color="$COLOR_PERCENT_HIGH"
                        fi
                    fi
                fi
            fi
        fi
    fi
else
    session_cost_raw="ccstat N/A"
    remaining_time_raw="ccstat N/A"
    daily_usage_raw="N/A"
    time_color="$COLOR_MUTED"
    usage_color="$COLOR_MUTED"
fi

# Apply colors to cost and time
if [ "$session_cost_raw" = "no session" ] || [ "$session_cost_raw" = "ccstat N/A" ]; then
    session_cost="${COLOR_MUTED}${session_cost_raw}${COLOR_RESET}"
else
    session_cost="${COLOR_COST}${session_cost_raw}${COLOR_RESET}"
fi

remaining_time="${time_color}${remaining_time_raw}${COLOR_RESET}"
daily_usage="${usage_color}${daily_usage_raw}${COLOR_RESET}"

# Create separator
sep="${COLOR_SEPARATOR}|${COLOR_RESET}"

# Output the status line
printf "%b %b %b %b %b %b %b %b %b %b %b" "$datetime" "$sep" "$branch" "$sep" "$model" "$sep" "$session_cost" "$sep" "$daily_usage" "$sep" "$remaining_time"