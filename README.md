# EmpApp

This is an iOS application (iPhone) for an employee directory. It fetches data from the webservice details like: Employee Name, Photo, Email, Team and Biography. This application does support light and dark mode.

## Build tools & versions used

- XCode Version : 13.4.1
- Source Control: GitHub, UI : GitHubDesktop
- Swift Version: 5.5
- iOS Deployment Target: v13.0 (Application is usable for version >= 13.0)

## Steps to run the app

- Clone the project from public repository: https://github.com/irahuldubey/EmpApp.git 
- Install the XCode Application
- Open the cloned reposoitory in XCode (Emp.xcodeproj)
- Build & Run the application using command + R or Product -> Run Option
- EmpApp is installed on iOS simulator and we can see the employees information in a list format.

## What areas of the app did you focus on?

- Networking: Created an abstraction layer for Rest API Service which is decoupled from the applicatio and can be used across projects by exporting it to a package manager.
- Caching: Abstraction over FileManager for caching the images which helps in lazy loading and do not require network to load the same images everytime.
- Architecture of the application using MVVM design pattern
- Decoupled the classes which are reusable and necessary extensions into its own directory same as networking and caching logic these files can also be moved to its own package to be reused across projects.  
- Protocol Oriented Programming and Dependency Injection
- Accessibility

## What was the reason for your focus? What problems were you trying to solve?

- Networking: I was trying to build a reusable system so that it can be scaled for any number of given webservice calls.
- Caching logic same way its easy encapsulated format and has factory of number of caching services you want your application to scale up.
- Protocol Oriented Programming and Dependency Injection for testability
- Accessibility to make sure application reaches wider audience and helps the people who really have challenges to use the applications, added accessibility tags for UI Automation tests

## How long did you spend on this project?

- I spent close to 5 hours on this project.

## Did you make any trade-offs for this project? What would you have done differently with more time?

- May be I would made the UI more intuitive 
- I also wanted to try few things for better UI performance but I wanted to support previous versions as well so didn't goto latest versions, its not a huge performance hit but it would be really nice to use the newer API's so that we get smooth performance with introduction of new API's from Apple
- Created packages for different modules, Rest Service, Caching Service etc and wrote more tests for it.
- Added LoggingManager to log the error and other cases which can help in debugging also that would have helped the application to upload the logs to Firebase or DataDog libraries

## What do you think is the weakest part of your project?

- I think I could have improved on UI 
- DOCC support for documentation.

## Did you copy any code or dependencies? Please make sure to attribute them here!

- I did copied few things from my previous github projects like networking and caching logic but to the most part it has been written by me with help of Apple Documentation around caching and networking.

## Is there any other information you’d like us to know?

- I would have added some more unit tests and also added UI tests to make sure we are solid on quality but I think this is a good product to goto market in terms of performance and quality code.
