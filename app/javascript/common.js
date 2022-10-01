document.addEventListener('DOMContentLoaded', function(){
  $('.slider').slick({
    dots: false,
    arrows: true,
    slidesToShow: 1
  });
});

const works = () => {
  const myWork = document.getElementById('my_work');
  if (!myWork) return null;
  if (myWork.textContent == 'デザイナー'){
    myWork.classList.add('_designer');
  }else if(myWork.textContent == 'エンジニア'){
    myWork.classList.add('_engineer');
  }
}

const links = () => {
  const nav1 = document.getElementById('nav01');
  const nav2 = document.getElementById('nav02');
  const nav3 = document.getElementById('nav03');
  if (!nav1) return null;

  const nav = [nav1, nav2, nav3]
  const link = location.pathname;

  for (let i = 0; i < 3; i++){
    let a = nav[i].getAttribute('href');
    if(a == link){
      nav[i].classList.add('_active');
    }
  }
}

const toggle = () => {
  const flag = document.getElementById('flag_field');
  const input = document.querySelector('input[type="checkbox"][name="project[member_flag]');
  if (!flag) return null;
  if (!flag.classList.contains('_checked') && (input.checked)){
    flag.classList.add('_checked');
  }
  input.addEventListener('click', (e) =>{
    if (!flag.classList.contains('_checked') && (input.checked)){
      flag.classList.add('_checked');
    }else if(flag.classList.contains('_checked') && (!input.checked)){
      flag.classList.remove('_checked');
    }
  });
}


window.addEventListener("load", works);
window.addEventListener("load", links);
window.addEventListener("load", toggle);



