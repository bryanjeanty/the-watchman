let down_btn = document.querySelector('.down-btn');
let count = 0;

down_btn.addEventListener('click', (event) => {
    let post_page = document.querySelector(`.posts-${ count }`);
    post_page.style.display = "block";
    count += 1;
});

let signout_btn = document.querySelector('.signout-btn');
signout_btn.addEventListener('click', (event) => {
    alert("We'll miss you 😢!");
});