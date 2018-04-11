*Dofile to exercise to create and move around the project's folders
*click on execute button or ctrl + D
clear all
set more off //似乎 --more-- 标签意义是折叠结果之类的东西
********************************************************************************
!mkdir DataSources
!mkdir DataManage
!mkdir DataUsing
!mkdir DataAnalysis
!mkdir DataOutput
!mkdir Report

*look where you are
pwd
dir //look at the folders and files in the current directory

*go into the DataSources folder
cd DataSources
pwd //check if now Stata is pointing inside the DataSources folder

*go back into the main project directory
cd ..
pwd //check again if you moved correctly

*move into the DataOutput folder
cd DataOutput
*into the DataOutput folder create two folders, one for tables, and one for figures
!mkdir Tabls
!mkdir Figures
*go into the Tables folder
cd Tabls

*now, how do you go back into the main project Folder? (up TWO steps)
cd ..\.. /*the first steps moves you from inside Tables to inside DataOutput, 
			the second from inside of DataOutput to inside ProjectFolder*/
* 发现在上面这样的注释方式下会只读取出第一行

/*Did you see how I added comments (appear in green). You should check that I applied
three different methods. Can you understand the difference between each of them?*/


/*now i realise i created a misstyped folder Tabls instead of Tables, now because there is no
content to be lost yet, let us delete it and generate a correct one*/
cd DataOutput
dir //check

shell rmdir "Tabls" /s //the system might ask you if you want to delete the folder: say "Yes"
* cmd指令：结尾+ /s 是删除目录 ~ = rm -rf
dir //check now

*now let us just create Tabls and rename Tables
!mkdir Tabls
dir

shell rename  Tabls  Tables
dir

!mkdir Maps
dir
!rename  Maps  Mappings //you see that shell or "!" have both the function of outshelling to the Windows command line

*let us go back within the main project folder
pwd //ops I forgot where I was :)
cd ..
!tree> tree.txt /a /f 
*列出目录结构并写入文档中
