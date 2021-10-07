# ⛔️ Deprecated
The project maintenance and support has been stopped. Since we are using a internal tool to generate our projects this template is superfluous.

<p align="center">
  <img src="https://raw.githubusercontent.com/JamitLabs/NewProjectTemplate-iOS/stable/Logo.png"
      width=650 height=200 alt="JamitLabs New Project Template iOS Edition">
</p>

<p align="center">
    <a href="https://app.bitrise.io/app/4e0ffcbee5191b5d">
        <img src="https://app.bitrise.io/app/4e0ffcbee5191b5d/status.svg?token=wwZogTBQSMYu1j6Bjhrm4g&branch=stable" alt="Build Status">
    </a>
    <a href="https://codebeat.co/projects/github-com-jamitlabs-newprojecttemplate-ios-stable">
        <img src="https://codebeat.co/badges/bffa8416-8267-4c88-bd07-07b18575d08e" alt="Codebeat Badge">
    </a>
    <img src="https://img.shields.io/badge/Swift-5.0-FFAC45.svg" alt="Swift: 5.0">
    <img src="https://img.shields.io/badge/Xcode-10.2-4598FF.svg" alt="Xcode: 10.2">
    <img src="https://img.shields.io/badge/Platforms-iOS-FF69B4.svg" alt="Platforms: iOS">
    <a href="https://github.com/JamitLabs/NewProjectTemplate-iOS/blob/stable/LICENSE.md">
				<img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="License: MIT">
    </a>
</p>

<p align="center">
    <a href="#about">About</a>
  • <a href="#getting-started">Getting Started</a>
  • <a href="#contributing">Contributing</a>
  • <a href="#license">License</a>
</p>

# New Project Template for iOS

A preconfigured **template** for **new iOS projects** with batteries included.


## About

This repo contains a project which is **preconfigured according to our Best Practices**. Given you agree with them, this project will save you a lot of time.

The following best practice **topics** are currently implemented:

- Localization in Swift like a Pro using [BartyCrouch](https://github.com/Flinesoft/BartyCrouch) ([article](https://medium.com/@Dschee/localization-in-swift-like-a-pro-48164203afe2) | no video yet)
- Xcode File Structure ([article](https://www.notion.so/jamitlabs/Xcode-File-Structure-201052f68e4f4108b44894b7afeb4776) | no video yet)
- Useful Scripts using [Beak](https://github.com/yonaskolb/Beak) & [direnv](https://github.com/direnv/direnv) (no article yet | no video yet)
- Improved Resource Loading via [SwiftGen](https://github.com/SwiftGen/SwiftGen) (no article yet | no video yet)
- Coordinators for Screen Flow Management via [Imperio](https://github.com/Flinesoft/Imperio) (no article yet | no video yet)
- Improved Error Handling via [MungoHealer](https://github.com/JamitLabs/MungoHealer) (no article yet | no video yet)
- Swift Code Conventions using [SwiftLint](https://github.com/realm/SwiftLint) (no article yet | no video yet)
- Local CI precheck (`ci lint`) (no article yet | no video yet)


## Getting Started

Here's a few simple steps on how you can use this project to kick-start your next project:

1. **Download a ZIP** of this project here and `cd` into its directory in a terminal
2. Run `brew bundle` in the command line and wait for **tools to be installed** via [Homebrew](https://brew.sh/) (this can take a minute)
3. Run `beak run link` to link the Beak scripts properly for execution, then restart your terminal
4. Run `project setup --name 'ProjectName' --orga 'OrganizationName'` with your `name` & `orga` (can take a while)
5. Set the the **Development Team** to yours

Additional options you probably want to check:

6. **Configure the languages** supported by your app (German & English by default)
7. Configure the **minimum deployment target** (12.0 by default)
8. Configure the **target devices** (Universal by default)

That's it! Start coding. 🎉 😊


## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion.

Please also try to follow the same syntax and semantic in your **commit messages** (see rationale [here](http://chris.beams.io/posts/git-commit/)).


## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See `LICENSE.md` for details.
