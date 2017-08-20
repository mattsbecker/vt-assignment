## Votem Coding Assignment
This repository contains an example application and supporting documentation for a product-related coding exercise for Votem.

## Contents of this repository
* Documents - Contains files relating to the requirements of the product exercise; including initial specification and my requirements for fulfilling those specifications.

* Application - An Xcode project containing the iOS application which fulfils this exercise.

## About this application
The application provides the following functionality:
* Sign In (enter any id and password)
* Register
* View available Contests
* View all ballots present in a contest
* Provides UI and data model support for single selection, multiple selection, and ordered selection Ballot types. All components use native iOS controls in order to ensure users are as familiar with interface paradigms as possible.
* Provides high level write-in support for Ballot types
* All Contest and Ballot object types are unit tested in a functional manner (create a contest, assign it ballots with types, ensure selections can be made, etc.)

## Notes
* Networking support could easily be added and is "in progress." High level Contest, Ballot, and BallotOption objects can be intialized independently, making serialization from network responses easy.
* Preparations for network persistence have been written, however the network layer was not implemented.
* The user's progress is currently stored in memory during the application's active lifecycle. Disk persistence could be added using CoreData object representations.


## iOS Application Requirements and Dependencies

* Requires a device running iOS 9 or later
* Requires at least Xcode 8.3
* Requires Cocoapods (https://cocoapods.org) for dependency management
    `sudo gem install cocoapods`
    
* Pods installed via Cocoapods are committed to this repository, so it isn't necessary to run `pod install` after cloning    

* Specifically designed with the iPhone as of now; the application uses autolayout so views will scale, however the results will not be optimal.

## Dependencies

Dependencies used for this application are:
* JVFloatLabeledTextField
* AFNetworking
* Masonry
* Mantle
* SAMKeychain
* IQKeyboardManager

## Running the Application
* Clone the repository
* Open `Application/Votem Example/Votem Example.xcworkspace`
* Run the device in an iOS Simulator OR
* Apply a valid Provisioning Profile in order to run the application on a device

