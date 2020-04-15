let courseArray = [];
let timeArray = [];

function addCourse() {
    fetch('../student_application/new.json', { method: 'GET' })
        .then(response => response.json())
        .then(json => {
            var tbody = document.getElementById('course_list');
            var newCourse = document.createElement('tr');
            var courseSelection = document.createElement('td');
            var courseText = document.createElement('select');
            if (courseArray.length == 0) {
                courseText.class = 0;
                courseArray.push(Number(courseText.class));
            } else {
                courseText.class = Number(courseArray[courseArray.length - 1]) + 1;
                courseArray.push(Number(courseText.class));
            }
            courseText.addEventListener('change', function() {
                timeOnCourse(json.descriptions, json.meetings, courseText);
                newCourse.class = courseText.value;
            });
            var arrayCourse = [];
            json.classNames.forEach(element => {
                var shortName = element.name.split(' ');
                var courseOption = document.createElement('option');
                courseOption.value = element.name;
                courseOption.textContent = shortName[0] + ' ' + shortName[1];
                courseText.append(courseOption);
            })
            var gradeSelection = document.createElement('td');
            var gradeText = document.createElement('select');
            var grades = ['A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F'];
            for (var i = 0; i < grades.length; i++) {
                var gradeOption = document.createElement('option');
                gradeOption.value = grades[i];
                gradeOption.textContent = grades[i];
                gradeText.appendChild(gradeOption);
            }
            var deleteButton = document.createElement('button');
            deleteButton.textContent = "Delete this Class";
            deleteButton.addEventListener('click', function() {
                document.getElementById(courseText.class).remove();
                for (var i = 0; i < courseArray.length; i++) {
                    if (courseText.class == courseArray[i]) {
                        courseArray.splice(i, 1);
                        timeArray.splice(i, 1);
                    }
                }
                newCourse.remove();
            });
            courseSelection.appendChild(courseText);
            gradeSelection.appendChild(gradeText);
            newCourse.appendChild(courseSelection);
            newCourse.appendChild(gradeSelection);
            newCourse.appendChild(deleteButton);
            tbody.appendChild(newCourse);
        });
}

function timeOnCourse(descriptions, meetings, courseText) {
    if (timeArray.includes(Number(courseText.class))) {
        document.getElementById(courseText.class).remove();
    } else {
        timeArray.push(courseText.class);
    }
    var value = courseText.value;
    var descriptionId = [];
    var times = [];
    descriptions.forEach(element => {
        if (element.name === value) {
            descriptionId.push(element.id);
        }
    })
    meetings.forEach(element => {
        if (descriptionId.includes(element.description_id)) {
            times.push(element.time);
        }
    })
    var timeTBody = document.getElementById('available_time');
    var newTimeRow = document.createElement('tr');
    newTimeRow.id = Number(courseText.class);
    var course = document.createElement('td');
    course.textContent = value.split(' ')[0] + ' ' + value.split(' ')[1];
    var timeTd = document.createElement('td');
    times = new Set(times);
    times.forEach(element => {
        if (element != "ARR") {
            var div = document.createElement('div');
            div.class = 'timeDiv';
            var checkBox = document.createElement('input');
            var label = document.createElement('label');
            checkBox.type = 'checkbox';
            checkBox.id = element;
            checkBox.value = element;
            label.htmlFor = element;
            label.textContent = element;
            div.append(checkBox);
            div.append(label);
            timeTd.append(div);
        }
    })
    newTimeRow.append(course);
    newTimeRow.append(timeTd);
    timeTBody.append(newTimeRow);

}

function addGradedCourse() {
    fetch('../student_application/new.json', { method: 'GET' })
        .then(response => response.json())
        .then(json => {
            console.log(json);
            var tbody = document.getElementById('graded_courses');
            var newCourse = document.createElement('tr');
            var courseSelection = document.createElement('td');
            var courseText = document.createElement('select');
            courseText.id = "gradedCourseText";
            var arrayCourse = [];
            json.classNames.forEach(element => {
                var shortName = element.name.split(' ');
                var courseOption = document.createElement('option');
                courseOption.value = element.name;
                courseOption.textContent = shortName[0] + ' ' + shortName[1];
                courseText.append(courseOption);
            })
            var deleteButton = document.createElement('button');
            deleteButton.textContent = "Delete this Class";
            deleteButton.addEventListener('click', function() {
                newCourse.remove();
            });
            courseSelection.appendChild(courseText);
            newCourse.appendChild(courseSelection);
            newCourse.appendChild(deleteButton);
            tbody.appendChild(newCourse);
        });
}