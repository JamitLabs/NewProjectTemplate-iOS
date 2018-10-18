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
    <img src="https://img.shields.io/badge/Swift-4-FFAC45.svg" alt="Swift: 4">
    <img src="https://img.shields.io/badge/Xcode-9-4598FF.svg" alt="Xcode: 9">
    <img src="https://img.shields.io/badge/Platforms-iOS-FF69B4.svg" alt="Platforms: iOS">
    <a href="https://github.com/JamitLabs/NewProjectTemplate-iOS/blob/stable/LICENSE.md">
				<img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="License: MIT">
    </a>
</p>

<p align="center">
    <a href="#about">About</a>
  • <a href="#getting-started">Getting Started</a>
  • <a href="https://jamitlabs.com">Website</a>
  • <a href="#contributing">Contributing</a>
  • <a href="#license">License</a>
</p>


# New Project Template for iOS

A preconfigured **template** for **new iOS projects** with batteries included.


## About

This repo contains a project which is **preconfigured according to our Best Practices** ([🇩🇪 Deutsch](https://jamitlabs.github.io/BestPractices/de/) | [🇺🇸 English](https://jamitlabs.github.io/BestPractices/en/)). Given you agree with them, this project will save you a lot of time.

The following best practice **topics** are currently implemented:

- How are the **files structured** both in Finder and within the Xcode project navigator? [🇩🇪](https://jamitlabs.github.io/BestPractices/de/articles/AP010-0200.html)
- What **code style** do we use in our apps for Swift? [🇩🇪](https://jamitlabs.github.io/BestPractices/de/articles/AP010-0300.html)
- Which **dependency manager** do we use?
- What **frameworks** do we include in (nearly) all our apps?
- How do we keep our **localizations updated**? [🇩🇪](https://jamitlabs.github.io/BestPractices/de/articles/AP010-0300.html)
- How do we access **dynamic-string resources** in a **safe** way? [🇩🇪](https://jamitlabs.github.io/BestPractices/de/articles/AP010-0300.html)
- What **branching logic & names** do we use in git? [🇩🇪](https://jamitlabs.github.io/BestPractices/de/articles/GN010-0300.html)
- How do we **structure** our **commit messages**? [🇩🇪](https://jamitlabs.github.io/BestPractices/de/articles/GN010-0400.html)
- What goes into our project-specific **`.gitignore` file**? [🇩🇪](https://jamitlabs.github.io/BestPractices/de/articles/GN010-0200.html)


Note that **not all** of our best practices have a related explaining article (in English) yet. We will add links to them within the list above once they are released.


## Getting Started

Here's a few simple steps on how you can use this project to kick-start your next project:

1. **Clone this repo** to your own Git server / GitHub fork
2. **Configure git-flow** with `productive`, `stable`, `work/` and `deploy/`
3. Run `brew bundle` in the command line and wait for **tools to be installed**
4. Run `beak run initialize --projectName YourProjectName --organization YourOrgaName` to **initialize the project**
5. Set the the **Development Team** to yours

Additional options you probably want to check:

6. **Configure the languages** supported by your app (German & English by default)
7. Configure the **minimum deployment target** (10.0 by default)
8. Configure the **target devices** (Universal by default)

That's it! Start coding. 🎉 😊


## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion.

Please also try to follow the same syntax and semantic in your **commit messages** (see rationale [here](http://chris.beams.io/posts/git-commit/)).


## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See `LICENSE.md` for details.
