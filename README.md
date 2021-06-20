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


# Supports
1. iPad All Orientations
2. iPhone All Orientations
3. iOS 13.0 and Above

# Used Library
1. HICharts : https://github.com/highcharts/highcharts-ios
I have used HICharts because its Web-Based and hence highly customisable, looks same on every platform. also I have used this in my previous project.



# Listing iPAD
![image](https://i.ibb.co/y52zm8p/Simulator-Screen-Shot-i-Pad-Pro-12-9-inch-5th-generation-2021-06-20-at-16-18-03.png)
![image](https://i.ibb.co/JW1vPLc/Simulator-Screen-Shot-i-Pad-Pro-12-9-inch-5th-generation-2021-06-20-at-16-20-03.png)
# Histotical Data iPAD
![image](https://i.ibb.co/2KXNKfW/Simulator-Screen-Shot-i-Pad-Pro-12-9-inch-5th-generation-2021-06-20-at-16-21-04.png)
![image](https://i.ibb.co/3mx6wr7/Simulator-Screen-Shot-i-Pad-Pro-12-9-inch-5th-generation-2021-06-20-at-16-21-30.png)
![image](https://i.ibb.co/CmRFHnT/Simulator-Screen-Shot-i-Pad-Pro-12-9-inch-5th-generation-2021-06-20-at-16-21-45.png)
# City Wise AQI - 30 sec Interval
![image](https://i.ibb.co/Yy3z4zr/Simulator-Screen-Shot-i-Pad-Pro-12-9-inch-5th-generation-2021-06-20-at-16-28-39.png)
# Listing iPhone
![image](https://i.ibb.co/mzM6CTq/Simulator-Screen-Shot-i-Phone-11-2021-06-20-at-16-15-14.png)
# All Cities AQI - Live (Latest update)
![image](https://i.ibb.co/3ckjfSY/Simulator-Screen-Shot-i-Phone-11-2021-06-20-at-16-15-36.png)
![image](https://i.ibb.co/yY3TNV5/Simulator-Screen-Shot-i-Phone-11-2021-06-20-at-16-15-44.png)
# Others
![image](https://i.ibb.co/yWCg0BX/Simulator-Screen-Shot-i-Phone-11-2021-06-20-at-16-15-58.png)
![image](https://i.ibb.co/XZv7GL7/Simulator-Screen-Shot-i-Phone-11-2021-06-20-at-16-16-06.png)
![image](https://i.ibb.co/xSTBDY5/Simulator-Screen-Shot-i-Phone-11-2021-06-20-at-16-16-09.png)
