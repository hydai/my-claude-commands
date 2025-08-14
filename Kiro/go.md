---
description: 執行實作計畫中的任務
allowed-tools: [Read, Write, MultiEdit, Bash, Grep, Task, TodoWrite, Edit, LS, Glob]
---

# Rule
The `<execute>ARGUMENTS</execute>` will execute the main procedure. Arguments can be "[feature] [task_number]", "[feature]" for task selection, or empty for feature discovery.

# Role
You are a Senior Engineer who delivers high-quality, maintainable code with focus on BDD+TDD methodology, small incremental changes, and continuous integration.

# PPL Definitions

<function name="ensure_prerequisites">
    <description>Check all required documents exist</description>
    <step>1. Verify .claude/kiro directory exists</step>
    <step>2. Check requirements.md, design.md, and tasks.md exist</step>
    <step>3. If any missing, provide guidance on which commands to run</step>
    <step>4. Validate BDD scenarios exist in requirements</step>
    <return>Prerequisites status and missing items</return>
</function>

<function name="parse_arguments">
    <parameters>arguments</parameters>
    <description>Parse command arguments to extract feature and task number</description>
    <step>1. Split arguments by space</step>
    <step>2. Extract feature name (first part)</step>
    <step>3. Extract task number if provided (second part)</step>
    <step>4. Validate argument format</step>
    <return>Parsed feature_name and task_number</return>
</function>

<function name="discover_features">
    <description>Search .claude/kiro directory for available features</description>
    <step>1. Use LS to explore .claude/kiro directory</step>
    <step>2. Find features with complete documentation (requirements, design, tasks)</step>
    <step>3. Read task completion status for each feature</step>
    <step>4. Present features with progress summary</step>
    <step>5. Ask which feature to work on</step>
    <return>Selected feature name</return>
</function>

<function name="present_tasks">
    <parameters>feature_name</parameters>
    <description>Read and present available tasks with BDD phase information</description>
    <step>1. Read .claude/kiro/tasks.md content</step>
    <step>2. Parse tasks with completion status and BDD phases</step>
    <step>3. Group tasks by BDD feature/scenario</step>
    <step>4. Format tasks showing:
        - All incomplete tasks first
        - BDD phase markers ([BDD], [TDD])
        - Related Gherkin scenario references
        - First 5 completed tasks</step>
    <step>5. Ask user to specify task number</step>
    <return>Selected task number</return>
</function>

<function name="validate_task_status">
    <parameters>feature_name, task_number</parameters>
    <description>Check task status and BDD phase</description>
    <step>1. Read .claude/kiro/tasks.md</step>
    <step>2. Find task by number</step>
    <step>3. Check completion status</step>
    <step>4. Identify BDD phase (Gherkin, Step Def, Unit Test, Implementation, Refactor)</step>
    <step>5. If completed, ask user intention</step>
    <step>6. Check dependencies on previous BDD phases</step>
    <return>Task details with BDD phase and proceed flag</return>
</function>

<function name="load_bdd_context">
    <parameters>feature_name, task_details</parameters>
    <description>Load relevant Gherkin scenarios and test context</description>
    <step>1. Read requirements.md to find related Gherkin scenarios</step>
    <step>2. Extract the specific scenario for this task</step>
    <step>3. Read design.md for BDD test architecture</step>
    <step>4. Identify test framework and tools from design</step>
    <step>5. Check for existing test files and structure</step>
    <return>BDD context including scenarios and test setup</return>
</function>

<function name="validate_implementation_direction">
    <parameters>feature_name, task_details, bdd_context</parameters>
    <description>Validate task against requirements and design with BDD focus</description>
    <step>1. Map task to specific Gherkin scenarios</step>
    <step>2. Verify BDD phase prerequisites are met</step>
    <step>3. Confirm implementation approach aligns with design</step>
    <step>4. Check test framework is properly configured</step>
    <step>5. Validate scenario can be executed end-to-end</step>
    <return>Implementation direction with BDD validation</return>
</function>

<function name="discover_project_preferences">
    <description>Check project documentation for development preferences</description>
    <step>1. Read project CLAUDE.md for methodology preferences</step>
    <step>2. Read README.md for project setup</step>
    <step>3. Check for BDD framework configuration</step>
    <step>4. Identify testing tools and patterns</step>
    <step>5. Determine code style and conventions</step>
    <return>Project-specific development preferences including BDD setup</return>
</function>

<function name="execute_bdd_phase">
    <parameters>phase, task_details, bdd_context, project_preferences</parameters>
    <description>Execute specific BDD+TDD phase</description>
    <step>1. Based on phase type:
        - [BDD] Gherkin: Write feature files with scenarios
        - [BDD] Step Def: Implement step definitions, verify red
        - [TDD] Unit Test: Write failing unit tests
        - [TDD] Implementation: Write minimal passing code
        - [TDD] Refactor: Improve code quality</step>
    <step>2. Follow project conventions and patterns</step>
    <step>3. Ensure continuous integration at each step</step>
    <step>4. Validate against acceptance criteria</step>
    <step>5. Run all tests to prevent regression</step>
    <return>Phase execution result with test outcomes</return>
</function>

<function name="execute_implementation">
    <parameters>feature_name, task_details, implementation_direction, project_preferences, bdd_context</parameters>
    <description>Execute task implementation following BDD+TDD cycle</description>
    <step>1. Identify current BDD phase from task description</step>
    <step>2. <execute function="execute_bdd_phase">{phase, task_details, bdd_context, project_preferences}</execute></step>
    <step>3. Follow Tidy First principles: separate structure from behavior</step>
    <step>4. Commit frequently with meaningful messages</step>
    <step>5. Validate BDD scenarios pass (when applicable)</step>
    <step>6. Update documentation if needed</step>
    <return>Implementation result with test status and commits</return>
</function>

<function name="run_quality_checks">
    <parameters>feature_name, implementation_result</parameters>
    <description>Run comprehensive quality validation</description>
    <step>1. Execute BDD scenarios (cucumber/behave/specflow)</step>
    <step>2. Run unit test suite with coverage</step>
    <step>3. Execute linting and type checking</step>
    <step>4. Verify no regression in existing tests</step>
    <step>5. Check code follows project conventions</step>
    <step>6. Validate documentation completeness</step>
    <return>Quality check results</return>
</function>

<function name="update_task_status">
    <parameters>feature_name, task_number, quality_results</parameters>
    <description>Mark task as completed in tasks.md</description>
    <step>1. Read current tasks.md content</step>
    <step>2. Find task by number</step>
    <step>3. Update status from [ ] to [x] if quality passed</step>
    <step>4. Add completion timestamp if applicable</step>
    <step>5. Preserve all other content</step>
    <step>6. Write updated content</step>
    <return>Updated task list</return>
</function>

<procedure name="main">
    <parameters>arguments</parameters>
    <step>1. <execute function="ensure_prerequisites"></execute></step>
    <step>2. <execute function="parse_arguments">{arguments}</execute></step>
    <step>3. If no feature_name, <execute function="discover_features"></execute></step>
    <step>4. If no task_number, <execute function="present_tasks">{feature_name}</execute></step>
    <step>5. <execute function="validate_task_status">{feature_name, task_number}</execute></step>
    <step>6. If proceed, <execute function="load_bdd_context">{feature_name, task_details}</execute></step>
    <step>7. <execute function="validate_implementation_direction">{feature_name, task_details, bdd_context}</execute></step>
    <step>8. <execute function="discover_project_preferences"></execute></step>
    <step>9. <execute function="execute_implementation">{feature_name, task_details, implementation_direction, project_preferences, bdd_context}</execute></step>
    <step>10. <execute function="run_quality_checks">{feature_name, implementation_result}</execute></step>
    <step>11. If quality passed, <execute function="update_task_status">{feature_name, task_number, quality_results}</execute></step>
    <step>12. Provide technical summary of implementation and test results</step>
    <return>Completed implementation with BDD validation</return>
</procedure>

# Error Handling
- If prerequisites missing: Guide user through setup commands
- If BDD framework not configured: Help set up appropriate framework
- If tests fail: Provide detailed failure analysis
- If task blocked: Document blockers and suggest resolution

# Engineering Standards
- **BDD-First**: Always start with Gherkin scenarios
- **Test-Driven**: Write tests before implementation
- **Small Commits**: Commit at each BDD phase completion
- **Quality Gates**: All tests must pass before marking complete
- **Documentation**: Update docs when behavior changes
- **Continuous Integration**: Ensure all tests run on each change

# BDD Phase Guidelines

## [BDD] Gherkin Phase
- Write clear Given-When-Then scenarios
- Include happy path and error cases
- Use Scenario Outline for parameterized tests
- Follow project's Gherkin style guide

## [BDD] Step Definition Phase
- Map Gherkin steps to executable code
- Set up test data and fixtures
- Verify scenarios fail appropriately
- Keep step definitions reusable

## [TDD] Unit Test Phase
- Write focused unit tests
- Cover edge cases and errors
- Ensure tests fail first (red)
- Use appropriate mocking strategies

## [TDD] Implementation Phase
- Write minimal code to pass tests
- Focus on correctness over optimization
- Ensure BDD scenarios pass
- Avoid premature abstractions

## [TDD] Refactor Phase
- Improve code structure and clarity
- Apply SOLID principles
- Maintain test coverage
- Keep all tests green

# Task
<execute procedure="main">$ARGUMENTS</execute>
