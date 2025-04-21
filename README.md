# 🎓 Student Performance & Feedback Tracker

A SQL-based data analysis project to manage and analyze student academic records. This system tracks student marks, attendance, faculty details, subject assignments, and student feedback.

## 📌 Project Highlights

- Built using pure **SQL** (no external tools like Power BI or Excel)
- Structured relational database with **6 interlinked tables**
- Populated with **realistic dummy data** (100–150 students)
- Includes complex SQL queries to derive valuable insights
- Ideal for academic institutions or training use-cases

## 🗂️ Database Structure

- **student**: Stores basic student details  
- **faculty**: Faculty names and associated departments  
- **subjects**: Subjects taught per semester, linked with faculty  
- **marks**: Marks obtained by each student per subject  
- **attendance**: Attendance percentage per subject  
- **feedback**: Feedback scores and comments on faculty by students

## 🔍 Sample Complex Queries

- Identify top-performing students per department
- Analyze faculty with highest average feedback
- Find subjects with poor overall performance
- Track students with low attendance and marks

## 🛠 Technologies Used

- MySQL
- CSV Data Import
- Relational Schema Design

## 📁 How to Use

1. Clone the repository  
2. Import the `student_performance.sql` file to create the schema  
3. Import datasets from CSV (multi-sheet Excel provided)  
4. Run SQL queries from the `queries.sql` file for insights

## 📄 License

This project is for educational and personal use. Contributions and suggestions are welcome!

---

**Author**: [Sachin Jalakoti](https://github.com/SachinJalakoti2003)
