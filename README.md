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



![alt text] (https://i.ibb.co/y52zm8p/Simulator-Screen-Shot-i-Pad-Pro-12-9-inch-5th-generation-2021-06-20-at-16-18-03.png)
https://ibb.co/KcP2HZ5
https://ibb.co/VBXmBPJ
https://ibb.co/Wvr8Qx6
https://ibb.co/YPHGLtq
https://ibb.co/T26sk1H
https://ibb.co/SdPhDhL
https://ibb.co/Yjqp7Qk
https://ibb.co/nBpcSPZ
https://ibb.co/9WG1wy3
https://ibb.co/wwvHdYC
https://ibb.co/SRgVN7P
https://ibb.co/Fbj5d35
https://ibb.co/5WHS6kc
