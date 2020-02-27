# Project #3 - Web Scrapter
The goal of this project is to create a web scraper for OSU classes and their attributes.

## Table of Contents
* [Technologies Used](#technologies-used)
* [Installation Guide](#installation-guide)
* [Usage Guide](#usage-guide)
* [Styling](#styling)
* [Authors](#authors)

## Technologies Used
- Ruby 2.6.3
- Rails 5.2.3
- SQLite 3.2.4

## Installation Guide
1. Download the zip archive of the OnTrack repository.
2. Navigate to the 'Project 3 OnTrack' directory.
3. Install the required gems with the following command:
```
$ bundle install
```

## Usage Guide
After installing the necessary gems, use the following command to launch the 
server:
```
$ rails server
```
Following this command, you should be presented with a TCP link. You can 
either copy and paste this, or type 'localhost:3000' into the web browser
of your choice.

This web page will display a table of CSE courses starting from the 1000 level
up to the 8000 level.  The table will display the following information:
- Course Number
- Class Number
- Component (Ex. LEC, LAB, Online)
- Time
- Location
- Instructor
- Session

CSE students could use this program to quickly and accurately display all the 
classes that are offered to them in a single table.

## Styling
All Ruby files in this project adhere to the rules in the style guide found [here](https://github.com/airbnb/ruby).

## Authors
- Jing George
- Jack Hanley
- Jack Thompson
- Snigdha Tiwari
- Von Mbah

