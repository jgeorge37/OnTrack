function addCourse() {
    fetch('../student_application/new.json', { method: 'GET' })
        .then(response => response.json())
        .then(json => {
            console.log(json);
            var tbody = document.getElementById('course_list');
            var newCourse = document.createElement('tr');
            var courseSelection = document.createElement('td');
            var courseText = document.createElement('select');
            courseText.addEventListener('change', timeOnCourse());
            var arrayCourse = [];
            json.classNames.forEach(element => {
                var array = element.name.split(' ');
                arrayCourse.push(array[0] + ' ' + array[1]);
            });
            arrayCourse.forEach(element => {
                var courseOption = document.createElement('option');;
                courseOption.value = element;
                courseOption.textContent = element;
                courseText.append(courseOption);
            });
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

function timeOnCourse() {
    console.log('change effect');
}