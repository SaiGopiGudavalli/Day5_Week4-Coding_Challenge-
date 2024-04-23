// const addContact = (e) => {
//     e.preventDefault();
//     const name = document.getElementById("name").value.trim();
//     const email = document.getElementById("email").value.trim();

//     if (!name || !email) return alert("Your input is blank!");

//     console.log(name, email, "jhgfdfghjk");

//     fetch("http://localhost:8080/contactmanager/contacts", {
//         method: "POST",
//         headers: {},
//         body: JSON.stringify({
//             name,
//             email,
//         }),
//     })
//         .then((response) => response.json())
//         .then((data) => console.log(data))
//         .catch((error) => console.log(error));
// };

const listContacts = () => {
    const contactList = document.getElementById('contactList');
    document.addEventListener('DOMContentLoaded', function () {
        fetch('/contactmanager/contact')
            .then(response => response.json())
            .then(data => {
                let list = ``;
                data.forEach(contact => {
                    console.log(contact);
                    list += `<tr>
                    <td>${contact.id}</td>
                    <td>${contact.name}</td>
                    <td>${contact.email}</td>
                </tr>`;
                });
                contactList.innerHTML = list;
            })
            .catch(error => console.error('Error:', error));
    });
}

listContacts();

