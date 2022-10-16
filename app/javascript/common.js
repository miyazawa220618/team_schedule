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
  const nav4 = document.getElementById('nav04');
  const nav5 = document.getElementById('nav05');
  const nav6 = document.getElementById('nav06');

  const nav = [nav1, nav2, nav3, nav4, nav5, nav6]
  const link = location.pathname;

  for (let i = 0; i < nav.length; i++){
    let a = nav[i].getAttribute('href');
    if(a == link){
      nav[i].classList.add('_active');
    }
  }
}

const myaverage = () => {
  const slickList = document.getElementsByClassName('average_box');
  const averageFill = document.getElementsByClassName('_fill');

  for (let i = 0; i < slickList.length; i++){
    let thisList = Number(slickList[i].textContent);

    if (thisList == 0){
      slickList[i].classList.add('_average40');
      averageFill[i].style.width = '0%';
    }else if (thisList < 40){
      slickList[i].classList.add('_average40');
      averageFill[i].style.width = thisList+'%';
    }else if ((thisList >= 40)&&(thisList < 75)){
      slickList[i].classList.add('_average75');
      averageFill[i].style.width = thisList+'%';
    }else if ((thisList >= 75)&&(thisList < 100)){
      slickList[i].classList.add('_average99');
      averageFill[i].style.width = thisList+'%';
    }
  }
}

const toggle = () => {
  const flag = document.getElementById('flag_field');
  const input = document.querySelector('input[type="checkbox"][name="project[member_flag]"]');
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

const memberCheck = () => {
  const checkField = document.getElementById('check_member');
  const input = document.querySelectorAll('input[type="checkbox"][name="project[user_ids][]');
  const label = document.querySelectorAll('label:not(.menu_btn, .edit_btn)');
  if (!checkField) return null;
  for (let i = 0; i < label.length; i++){
    const inputA = input[i];
    const labelA = label[i];

    const inputBox = document.createElement('div');
    inputBox.setAttribute('class', 'check_label');

    const inputBtn = document.createElement('span');
    inputBtn.setAttribute('class', 'check_square');

    labelA.appendChild(inputA);
    labelA.appendChild(inputBtn);
    inputBox.appendChild(labelA);

    checkField.appendChild(inputBox);
  }
}

const projectPhase = () => {
  const phaseAll = document.getElementById('phase_all');
  const phaseAfter = document.getElementById('phase_after');
  const phaseNow = document.getElementById('phase_now');
  const phaseBefore = document.getElementById('phase_before');
  const phaseAfSec = document.getElementById('phase_after_sec');
  const phaseNowSec = document.getElementById('phase_now_sec');
  const phaseBefSec = document.getElementById('phase_before_sec');
  const projectBox = document.querySelectorAll('.project_box');
  if (!phaseAll) return null;

  if (!phaseNowSec.classList.contains('-active')){
    phaseNowSec.classList.add('-active');
    phaseNow.classList.add('-active');
  }

  phaseAll.addEventListener('click', (e) => {

    if (phaseAfter.classList.contains('-active')){
      phaseAfter.classList.remove('-active');
      phaseAfSec.classList.remove('-active');
    }else if (phaseNow.classList.contains('-active')){
      phaseNow.classList.remove('-active');
      phaseNowSec.classList.remove('-active');
    }else if (phaseBefore.classList.contains('-active')){
      phaseBefore.classList.remove('-active');
      phaseBefSec.classList.remove('-active');
    }

    phaseAll.classList.add('-active');
    for (let i = 0; i < projectBox.length; i++){
      projectBox[i].classList.add('-active');
    }
  });

  phaseAfter.addEventListener('click', (e) => {
    for (let i = 0; i < projectBox.length; i++){
      projectBox[i].classList.remove('-active');
    }

    if (phaseNow.classList.contains('-active')){
      phaseNow.classList.remove('-active');
    }else if (phaseBefore.classList.contains('-active')){
      phaseBefore.classList.remove('-active');
    }else if (phaseAll.classList.contains('-active')){
      phaseAll.classList.remove('-active');
    }

    phaseAfSec.classList.add('-active');
    phaseAfter.classList.add('-active');
    
  });

  phaseNow.addEventListener('click', (e) => {
    for (let i = 0; i < projectBox.length; i++){
      projectBox[i].classList.remove('-active');
    }

    if (phaseAll.classList.contains('-active')){
      phaseAll.classList.remove('-active');
    }else if (phaseAfter.classList.contains('-active')){
      phaseAfter.classList.remove('-active');
    }else if (phaseBefore.classList.contains('-active')){
      phaseBefore.classList.remove('-active');
    }

    phaseNowSec.classList.add('-active');
    phaseNow.classList.add('-active');
  });

  phaseBefore.addEventListener('click', (e) => {

    for (let i = 0; i < projectBox.length; i++){
      projectBox[i].classList.remove('-active');
    }

    if (phaseAll.classList.contains('-active')){
      phaseAll.classList.remove('-active');
    }else if (phaseAfter.classList.contains('-active')){
      phaseAfter.classList.remove('-active');
    }else if (phaseNow.classList.contains('-active')){
      phaseNow.classList.remove('-active');
    }

    phaseBefSec.classList.add('-active');
    phaseBefore.classList.add('-active');
  });
}


window.addEventListener("load", works);
window.addEventListener("load", links);
window.addEventListener("load", myaverage);
window.addEventListener("load", toggle);
window.addEventListener("load", memberCheck);
window.addEventListener("load", projectPhase);

document.addEventListener('DOMContentLoaded', function(){
  $('.slider').slick({
    dots: false,
    arrows: true,
    slidesToShow: 1
  });
});

jQuery(function($) {
  $('.project_acco_btn').click(function() {
    $(this).toggleClass('-open');
    $(this).next().slideToggle();
  });
});

$(function () {
  $('a[href^="#"]').click(function () {
    let speed = 400;
    const href = $(this).attr("href");
    const target = $(href == "#" || href == "" ? 'html' : href);
    const position = target.offset().top;
    $('body,html').animate({ scrollTop: position }, speed, 'swing');
    return false;
  });
});

window.addEventListener("load", function(){
  let speed = 400;
  const element = document.getElementById('share_form');
  if (!element) return null;
  const rect = element.getBoundingClientRect();
  const position = rect.top + window.pageYOffset;
  const editBtn = document.querySelectorAll(".share_edit_btn a")
  
  editBtn.forEach(function(e){
    e.addEventListener('click',function(){
      $('body,html').animate({ scrollTop: position }, speed, 'swing');
    })
  });
});

