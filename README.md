# BillSplit
#### Video Demo:  <https://youtu.be/4NsBLNTYNGY>
#### Description:
BillSplit - iOS application, allowing its users to conveniently split the bill in any suitable way between up to 10 people. First the user selects the number of people participating, then enters the bill subtotal and bill tax separately, and then chooses if to split it equally between participants, or to split the bill by each bill item. After that being done, app presents results, allowing also to include any tip (calculated from subtotal) and split it between parties as well.

This application was developed using Swift language version 4.2 and Xcode IDE 10.1.
Built in a way that would look good on both small and big screens.

The project contains several files:
AppDelegate.swift - system file created automatically
LaunchScreen.storyboard - system file created automatically, presenting app’s launch screen
Info.plist - system file created automatically, essential configuration data for a bundle
Main.storyboard - presenting app schema, labels, buttons and other objects
Assets.xcassets - directory containing app icons

Person.swift
IntroViewController.swift
SubtotalViewController.swift
ItemsViewController.swift
PeopleViewController.swift
ResultsViewController.swift
TipViewController.swift

**Person.swift** - holding code for a data structure (struct) “Person” that is used across several View Controllers. The struct has name and share properties, as well as 2 mutating functions allowing to change the share.

**IntroViewController.swift** - holds code for the welcome view presented to the user, where number of participants (between 2 and 10) is chosen. It’s implemented in a picker view way. It is also the view user comes back to, if in the end wishes to start over.

**SubtotalViewController.swift** - second view manages subtotal and tax entries by the user. Tax entry can be skipped. Code contains creation of parties as Person structs, labels/buttons outlets, user entry logic and two options “Split equally” and “Split by items”, which take the user to Results and Items View Controllers respectively.

**ItemsViewController.swift** - code contains logic behind Items view, where user can entry each item cost manually, and choose which of the participants it belongs to. Multiple people selection is allowed for better experience (item in this case is split between chosen parties). At any time the user can see the remaining bill sum and choose to split it equally between parties. If remainder is 0, user is pushed to Results. Scroll view is in place in main.storyboard for smaller screens.

**PeopleViewController.swift** - logical continuation of ItemsViewController. The table view is presented, where user selects which participants are associated with a specific item. After selecting and pressing “Done” button, chosen party is seen in ItemsViewController.

**ResultsViewController.swift** - holds necessary labels for presenting data: including subtotal, tax, tip, grand total and shares for each party (presents only share labels that are in use). Contains slider logic for a tip (from 5% to 25% of subtotal), which dynamically changes tip value, grand total and shares in any direction. It is also possible to set tip manually, pressing on “tip” - which brings the user to TipViewController presented modally. “Start over” button brings users back to the beginning IntroViewController. Scroll view is in place in main.storyboard for smaller screens.

**TipViewController.swift** - contains logic for user entry of a custom tip. After hitting “Done”, ResultsViewController updates tip and calculations.

Enjoy. Let’s kill the bill!