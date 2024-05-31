## Sleep Tracker & Calculator
## 1 Abstract
The purpose of this app is twofold:
1. Help users track their sleep so that they can understand when and for how long they sleep. Tracking this information will help users to understand trends in their sleep schedule, duration, and quality.
2. Use data on sleep cycles to guide users on when best to fall asleep/wake up to maximize sleep quality without compromising on duration.
## 2 Introduction
In today's expeditious world, getting a good night of sleep is more important than ever. However, understanding and improving sleep habits can be a challenge for many. Introducing our Sleep Tracker & Calculator app, it is designed to revolutionize the way users go about their sleep routine. This tool not only helps users track their sleep patterns, but also provides valuable insights into sleep quality and duration. By analyzing data gathered on sleep cycles, the app offers personalized recommendations on the optimal times to fall asleep and wake up. Whether you're struggling with insomnia, jet lag, or simply want to optimize your sleep schedule, our app is your solution for achieving better sleep and overall health.
## 3 Architectural Design
### 3.1 Class Diagram
This portion contains diagrams for the design of our software. Consisting of one boundary class, two control classes, and two entity classes, below we have a visual representation of the flow of data and interactions within the system.
![class diagram](class-diagram.png)

### 3.2 Sequence Diagram
The sequence diagram shows the flow of data through the system, and how the intricate parts of the system communicate with each other. It shows the sequence for registering and logging into an account, and entering/deleting
an entry. Starting off, the UI is loaded and presents a regristration/login page. When a user registers the details of an account, the data is sent to the Database class where it is verified. Every new account will have a personal collections list named the same thing as their username to store sleep records. Once verified, the account will be created and the user will still be prompted to login. After requesting to login, the data will again be sent to the database and verify if the information is right. When the user login is accepted, the page will redirect to the main dashboard. From there the user may choose to enter an entry, where the data is then sent to the sleepController class. This class will verify and store the data in an instance of a sleepRecord. The record will then be sent to the database class where it is then uploaded and stored. If the user wishes to see their history, their username will be sent to the database. The collection list associated with the same username gets pulled, where it is then sent to the sleepController class. This class will use mathematics to find trends, and send the calculations and records back to the UI.

![sequence diagram](sequence-diagram.png)

### 3.3 Usecase Diagram
The usecase diagram shows how the user may interact with the system.
![usecase diagram](usecase-diagram.png)

## 4 User Guide/Implementation
## 5 Future Scope
## 6 Conclusion
## 7 Walkthrough
