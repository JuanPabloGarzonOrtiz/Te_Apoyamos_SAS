function llamadaSVG(elemento, ruta){
    fetch(ruta)
        .then(res => res.text()) 
        .then(svg => {
            elemento.innerHTML = svg;
            return svg;
        });
}

function modificacion_Header(bodyContains){
    if ((window.scrollY > 50 || bodyContains) && window.innerWidth > 800) {
        document.body.classList.add("scrolled");
        document.getElementById("imagenDinamica").src = 'build/assets/img/logo-White.png';
        llamadaSVG(document.getElementById("ln_inicio"), '/build/assets/svg/inicio.svg');
        llamadaSVG(document.getElementById("ln_servicios"), '/build/assets/svg/servicios.svg');
        llamadaSVG(document.getElementById("ln_abogados"), '/build/assets/svg/abogados.svg');
        llamadaSVG(document.getElementById("ln_nosotros"), '/build/assets/svg/nosotros.svg');
        llamadaSVG(document.getElementById("ln_contacto"), '/build/assets/svg/contacto.svg');
        llamadaSVG(document.getElementById("ln_hv"), '/build/assets/svg/hv.svg');
    }else if(window.innerWidth < 720){
        document.getElementById("ln_abogados").innerHTML = "Abogados";
    }
    else {
        document.body.classList.remove("scrolled");
        document.getElementById("imagenDinamica").src = 'build/assets/img/logo.png';
        document.getElementById("ln_inicio").innerHTML = "Inicio";
        document.getElementById("ln_servicios").innerHTML = "Servicios";
        document.getElementById("ln_abogados").innerHTML = "";
        document.getElementById("ln_nosotros").innerHTML = "Nosotros";
        document.getElementById("ln_contacto").innerHTML = "Contacto";
        document.getElementById("ln_hv").innerHTML = "";
    }
};

window.addEventListener("scroll", function () {
    if (!document.querySelector(".service_only") && !document.querySelector(".body-chat")){ 
        modificacion_Header();
    }
});
window.addEventListener('DOMContentLoaded', () =>{
    var containsSection = ['body-chat', 'formulario'].some(section => document.body.classList.contains(section));
    if (containsSection){
        window.addEventListener('scroll',modificacion_Header(true));
        llamadaSVG(document.getElementById('svg-send'), '/build/assets/svg/send.svg');
    }else{
        document.querySelectorAll(".especialidad, .otros_servicios").forEach(div =>{
            let url_SVG;
            switch (div.dataset.nombre){
                case "Derecho Mercantil":
                    url_SVG = '/build/assets/svg/mercantil.svg'; break;
                case "Derecho Internacional Publico":
                    url_SVG = '/build/assets/svg/internacional-publico.svg'; break;
                case "Derecho de Propiedad Intelectual":
                    url_SVG = '/build/assets/svg/propiedad-intelectual.svg'; break;
                case "Derecho Informatico":
                    url_SVG = '/build/assets/svg/informatico.svg'; break;
                case "Derecho Penal":
                    url_SVG = '/build/assets/svg/penal.svg'; break;
                case "Derecho Civil":
                    url_SVG = '/build/assets/svg/civil.svg'; break;
                case "Derecho Laboral":
                    url_SVG = '/build/assets/svg/laboral.svg'; break;
                case "Derecho Constitucional":
                    url_SVG = '/build/assets/svg/constitucional.svg'; break;
                case "Derecho Administrativo":
                    url_SVG = '/build/assets/svg/administrativo.svg'; break;
                case "Derecho Tribunal":
                    url_SVG = '/build/assets/svg/tribunal.svg'; break;
            }
            llamadaSVG(div.querySelector(".svg-container"), url_SVG);
        });
    }
});