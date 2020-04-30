# Project #5 - CSE Grader Assignment System (OnTrack)
The goal of this project was to create an application to streamline the grader hiring process for the CSE department at OSU.

## Table of Contents
* [Technologies Used](#technologies-used)
* [Required Functionality Included](#required-functionality)
* [Additional Functionality Included](#additional-functionality)
* [Installation](#installation)
* [Usage Guide](#usage-guide)
* [Styling](#styling)
* [Authors](#authors)

## Technologies Used
- Ruby 2.6.5
- Rails 6.0.2.2
- PostgreSQL
- [Mechanize](https://github.com/sparklemotion/mechanize)
- [Devise](https://github.com/heartcombo/devise)

## Required Functionality Included
- Application Submission
- Administrator Interface
- Available Course/Sections
- Recommendation Submission

## Additional Functionality Included
- Login System
- Evaluation System
- Ability to assign and remove graders from classes
- Use of external data source
- Ability to adjust number of grader positions and attendance requirements in batches


## Installation
1. Download and extract the zip archive of the OnTrack repository.
2. Navigate to the 'Project 5 OnTrack' directory.
3. Install the required gems with the following command:
```
$ bundle install
```
4. Construct the database and load content with the following command (this will take a couple minutes):
```
$ rails db:reset
```

## Usage
After installing the necessary gems and populating the database, use the following command to launch the server:
```
$ rails server
```
Following this command, you should be presented with a TCP link. You can
either copy and paste this, or type 'localhost:3000' into the web browser
of your choice.

**Accounts**
There are three different account types: Student, Teacher, and Admin. Each account type has different permissions regarding which section of the site they may access.

**Configuration**
The Configuration page is only accessible by Admins. This page is where an Admin may re-run the web scraper to get the most up-to-date class schedule. It is also where an Admin may specify how many graders need to be hired for certain classes, and whether or not attendance is required.

For example, all 2221 LAB classes in SU20 can be configured to have 2 grader positions with grader attendance required with one form submission.

**Administrator Panel**
This section is only accessible to Admins. This page shows the listings of classes, with details such as number of open grading positions and the names of graders currently assigned. This list may be filtered by semester, session, class name, and whether the classes have open grading positions.

Each class has an "Edit" link that takes the user to a new page. This page lists details of the current graders as well as candidates who are eligible to grade the class, including evaluations scores, recommendations, GPA, and grade in the class. If attendance is required for the class, only students who are available at the class meeting time will be shown. The Admin then has the option to remove or assign graders to the class.

**Application**
This section is for students to fill out an application to be a grader. Applicants fill out identifying information as well as classes they are interested in grading with the grade they received. Students must also specify which times they are available to grade the classes they are interested in.

**Recommendation**
This section is for teachers to fill out a recommendation of a student that they have taught to be a grader. The teacher will specify which class they are recommending the student for, and may provide a general endorsement or a specific request for the student to grade a particular class section.

**Evaluation**
The section is for teachers to fill out an evaluation of a student who grader their class. There are four categories that the student can be rated in out of five points: grading quality, punctuality, communication, and course knowledge.

## Styling
All Ruby files in this project adhere to the rules in the style guide found [here](https://github.com/airbnb/ruby).
All views are styled with SCSS and are printed to the site using HTML.

## Presentation Link
https://docs.google.com/presentation/d/1nq994_W9ReOBMVf5kYcdqXTDPxBwjXe-24c_JyURz0U/edit?usp=sharing

## Authors
- Jing George
- Jack Hanley
- Jack Thompson
- Snigdha Tiwari
- Von Mbah
