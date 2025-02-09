window.addEventListener('scroll', () => {
    const div = document.querySelector('.container-fluid');

    if (window.scrollY > 50 && window.innerWidth > 975) {
        div.classList.add('proceso-div');
    }else {
        div.classList.remove('proceso-div');
    }
});


