function addCourse() {
    var tbody = document.getElementById('course_list');
    var newCourse = document.createElement('tr');
    var selection = document.createElement('td');
    var grade = document.createElement('td');
    var gradeText = document.createElement('input');
    var deleteButton = document.createElement('button');
    deleteButton.textContent('Delete This Course');
    deleteButton.addEventListener('click', deleteButton());
    grade.appendChild(gradeText);
    newCourse.appendChild(selection);
    newCourse.appendChild(grade);
    newCourse.appendChild(deleteButton);
    tbody.appendChild(newCourse);
}