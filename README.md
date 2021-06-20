# AQI
This Project is regading getting live values of Air Quality index from varous cities.


Project achitecture
1. Network Manager (Singleton)
2. CoreData Manager (Singleton)
3. Three View Controllers
        i ) Listing View for the City listing and their respective AQI.(MVVM)
        ii) Bar Chart View (MVVM)
        iii) Line Chart View (MVVM)
        


I have used a KVO design partern for registing and listening data packets from server.

Network Manager 
It is responsible from creating connection and receiving general data packets from server.


CoreData Manager
It is responsible to abstract the working of coredata, it accept the Data Models and Provide values in Data Model format.

It also retrive data on background context to avoid freezing main thread



