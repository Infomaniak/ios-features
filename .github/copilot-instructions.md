# Copilot Coding Agent Onboarding for Infomaniak/ios-features

## High Level Repository Overview

- **Purpose**: This repository provides reusable Swift frameworks for Infomaniak iOS applications, notably `MyKSuite`, `InterAppLogin`, and `KSuiteUtils`. These libraries depend on internal Infomaniak packages and third-party libraries like Nuke.
- **Type/Size**: Modular Swift Package Manager (SPM) project for iOS 15+, primarily Swift. The repository is medium-sized, structured for multi-library/distribution.
- **Languages/Frameworks**: Swift 5.10, Swift Package Manager, iOS 15+, and Xcode.

## Build, Validate, and Environment Setup

### Tooling and Versions
- **Swift version**: 5.10 (see `.swift-version`)
- **Linting/Formatting**: `swiftlint` (0.59.1), `swiftformat` (0.56.2) — see `.mise.toml` for tool versions.
- **Other Tools**: `swiftgen` (latest)
- **Dependencies**: Managed via SwiftPM (`Package.swift`)
- **CI**: Linting and formatting enforced by `.swiftlint.yml` and `.swiftformat`.

### Bootstrap & Environment Setup
1. **Install Swift 5.10** (or ensure your environment matches `.swift-version`).
2. **Install required tools** (recommended: use [mise](https://github.com/jdx/mise) or manually):
    - `swiftlint@0.59.1`
    - `swiftformat@0.56.2`
    - `swiftgen` (latest)

### Build
- To build all targets:
  ```sh
  swift build
  ```
- Always run `swift package resolve` if dependencies change.
- If Xcode is used, open the project/workspace and build as usual.

### Test
- Run all tests:
  ```sh
  swift test
  ```
- For Xcode: select a test target and run tests.

### Lint
- Run SwiftLint:
  ```sh
  swiftlint --config .swiftlint.yml
  ```
- Run SwiftFormat:
  ```sh
  swiftformat . --config .swiftformat
  ```
- Exclusions for generated/derived sources are set in both configs.

### Additional Checks
- **CI**: Pull requests are validated by workflow(s) that enforce build, lint, and test.
- **Conventional Commits**: Follow the Conventional Commits specification for commit messages.

### Pre-commit/PR Steps (ALWAYS do these)
1. Run `swiftformat` and `swiftlint` manually to catch issues early.
2. Run `swift build && swift test` before opening a PR.
3. Ensure new/changed files are not excluded by lint/test configs.
4. Do not modify generated or excluded files unless specifically required.

## Project Layout & Key Files

```
/
├── .github/               # GitHub workflows and templates
├── Sources/               # Main source code, one folder per library
├── Tests/                 # Unit tests, parallel structure to Sources
├── Package.swift          # SPM configuration (targets, dependencies)
├── .swift-version         # Swift version (5.10)
├── .mise.toml             # Tool version pinning (lint/format/gen)
├── .swiftlint.yml         # SwiftLint configuration
├── .swiftformat           # SwiftFormat configuration
├── .sonarcloud.properties # SonarCloud settings
├── LICENSE
├── .gitignore
└── (No README at time of inventory)
```

- **Sources/**: Entry point for each library (`MyKSuite`, `InterAppLogin`, `KSuiteUtils`). Avoid editing `Generated` subfolders.
- **Tests/**: All test targets.
- **GitHub Actions**: Present in `.github/`, used for CI (details inside the directory).

## Key Dependencies (from Package.swift)
- Infomaniak packages: `ios-core-ui`, `ios-core`, `ios-dependency-injection`
- 3rd party: `Nuke`

## Lint/Format/Analysis
- Lint: `.swiftlint.yml` (custom and opt-in rules, exclusions for generated/test/derived code)
- Format: `.swiftformat` (strict configuration, disables/enables many rules, exclusions)


## Guidance for Coding Agent

- **Trust the instructions above** — only search the repo if a required step is missing or an error occurs.
- **Prioritize**: Always format, lint, build, and test before submitting changes. Use only documented tools and versions.
- **Do not**: Edit excluded/generated files or introduce dependencies not defined in `Package.swift`.
- **If in doubt**: Consult configuration files listed here before spending time searching the codebase.

## Pull Request Review Instructions

- Pay attention for consistency with existing code style and architecture.
- Ensure new UI uses Design System components where applicable. Notably IKPaddings, IKRadius, IKIconSize.
- Ensure strings are localized and not hardcoded.

Some common UI errors with correction:

Do: `VStack(alignment: .leading, spacing: IKPadding.micro)`
Don't do: `VStack(alignment: .leading)`

Do: `.padding(value: .medium)`
Don't do: `.padding(16)`

Do: `RoundedRectangle(cornerRadius: IKRadius.large)`
Don't do: `RoundedRectangle(cornerRadius: 12)`

This onboarding document is your definitive guide for this repository. Only deviate if you discover a build or validation error not covered above.
