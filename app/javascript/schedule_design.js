const this_day = () => {
  const dayTo = document.getElementById("today");
  const dayDox = document.querySelectorAll('.date_box li');
  for (let i = 0; i < dayDox.length; i++){
    if (dayTo.textContent == dayDox[i].textContent){
      dayDox[i].classList.add('_today');
    }
  }
}

const holiday = () => {
  const dayHol = document.querySelectorAll('.holiday');
  const dayDox = document.querySelectorAll('.date_box li');
  for (let i = 0; i < dayDox.length; i++){
    for (let n = 0; n < dayHol.length; n++){
      if (dayDox[i].textContent == dayHol[n].textContent){
        dayDox[i].classList.add('_holiday');
      }
    }
    }
  }

const sch_len = () => {
  const schBorder = document.getElementsByClassName('schedule_border');

  for (let i = 0; i < schBorder.length; i++){
    const schStart = schBorder[i].dataset.startdate;
    const schEnd = schBorder[i].dataset.enddate;
    const getStartDate = new Date(schStart);
    const getEndDate = new Date(schEnd);

    if ((getEndDate - getStartDate) / 86400000 == 0){
        schBorder[i].style.width = 'calc(20% - 6px)';
    }else if ((getEndDate - getStartDate) / 86400000 == 1){
      if (getStartDate.getDay() != 5){
        schBorder[i].style.width = 'calc(40% - 6px)';
      }
    }else if ((getEndDate - getStartDate) / 86400000 == 2){
      if (getStartDate.getDay() == 4){
        schBorder[i].style.width = 'calc(40% - 6px)';
      }else if (getStartDate.getDay() != 5) {
        schBorder[i].style.width = 'calc(60% - 4px)';
      }
    }else if ((getEndDate - getStartDate) / 86400000 == 3){
      if (getStartDate.getDay() == 4){
        schBorder[i].style.width = 'calc(40% - 6px)';
      }else if (getStartDate.getDay() == 3) {
        schBorder[i].style.width = 'calc(60% - 4px)';
      }else if (getStartDate.getDay() != 5){
        schBorder[i].style.width = 'calc(80% - 2px)';
      }
    }else if ((getEndDate - getStartDate) / 86400000 >= 4){
      if (getStartDate.getDay() == 4){
        schBorder[i].style.width = 'calc(40% - 6px)';
      }else if (getStartDate.getDay() == 3) {
        schBorder[i].style.width = 'calc(60% - 4px)';
      }else if (getStartDate.getDay() == 2){
        schBorder[i].style.width = 'calc(80% - 2px)';
      }else if (getStartDate.getDay() == 1){
        schBorder[i].style.width = 'calc(100%)';
      }
    }
  
    if (getStartDate.getDay() == 2){
      schBorder[i].style.marginLeft = 'calc(20% + 2px)';
    }else if (getStartDate.getDay() == 3){
      schBorder[i].style.marginLeft = 'calc(40% + 4px)';
    }else if (getStartDate.getDay() == 4){
      schBorder[i].style.marginLeft = 'calc(60% + 6px)';
    }else if (getStartDate.getDay() == 5){
      schBorder[i].style.marginLeft = 'calc(80% + 8px)';
    }
  }
}


const project_url = () =>{
  const projectSelect = document.getElementById('project_select');
  const thisUrl = location.pathname;
  const splitUrl = thisUrl.split('/');
  if ((splitUrl[0] == 'projects')){

  }
}

window.addEventListener("load", this_day);
window.addEventListener("load", holiday);
window.addEventListener("load", sch_len);
window.addEventListener("load", project_url);


const schedule_acc = () => {
  const listAll = document.querySelectorAll('.accordion_list');
  const btnTop = document.getElementById('btn_top');
  const btnBottom = document.getElementById('btn_bottom');
  if (!btnTop) return null;

  btnTop.addEventListener('click', () => {
    if (btnBottom.classList.contains('not_move')){
      btnBottom.classList.remove('not_move');
    }

    const lookAll = document.querySelectorAll('._look');
    if (listAll[0] == lookAll[0]) {
      return null;
    }else if(listAll[1] == lookAll[0]){
      btnTop.classList.add('not_move');
      listAll[0].classList.add('_look');
      listAll[4].classList.remove('_look');
    }else{
      for (let i = 0; i < listAll.length; i++){
        if (listAll[i] == lookAll[0]){
          const lookTop = (listAll[i - 1]);
          lookTop.classList.add('_look');
        }
      }
      lookAll[3].classList.remove('_look');
    }
  });

  btnBottom.addEventListener('click', () => {
    if (btnTop.classList.contains('not_move')){
      btnTop.classList.remove('not_move');
    }

    const lookAll = document.querySelectorAll('._look');

    if (listAll[14] == lookAll[3]) {
      return null;
    }else if(listAll[13] == lookAll[3]){
      btnBottom.classList.add('not_move');
      listAll[14].classList.add('_look');
      listAll[10].classList.remove('_look');
    }else{
      for (let i = 0; i < listAll.length; i++){
        if (listAll[i] == lookAll[3]){
          const lookBottom = (listAll[i + 1]);
          lookBottom.classList.add('_look');
        }
      }
      lookAll[0].classList.remove('_look');
    }
  });
}

window.addEventListener("load", schedule_acc);

