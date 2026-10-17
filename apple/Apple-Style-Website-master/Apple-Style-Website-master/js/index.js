
  // Swiper 
  let currentImageIndex = 0

  let images = document.querySelectorAll('.slider>.slide>img')

  let dotItems = document.querySelectorAll('.dot-container>.dot')

  function displapy(n){
    let previousIndex;
    let nextIndex;
    // for (let index = 0; index < images.length; index++) {
    //   images[index].style.displapy='none';
    // }  
    if (n===0){
      previousIndex = 4
      nextIndex = n+1
    }else if (n===4){
      nextIndex = 0
      previousIndex = n-1
    }else if (n>=5){
      currentImageIndex = 0
      n = 0
      previousIndex = 4
      nextIndex = 1
    }else{
      nextIndex = n+1
      previousIndex = n-1
    }
    images[0].src = `../images/swiper/${previousIndex+1}.jpg`

    images[1].src = `../images/swiper/${n+1}.jpg`

    images[2].src = `../images/swiper/${nextIndex+1}.jpg`
  }

  function clickcircle(n){
    for (let index = 0; index < dotItems.length; index++) {
      dotItems[index].style.backgroundColor = '#d0cdcd'
      
    }
    dotItems[n-1].style.backgroundColor = '#212122'
    displapy(n-1)
  }

  let myInterval = setInterval(()=>{
    displapy(currentImageIndex)
    clickcircle(currentImageIndex+1)
    currentImageIndex++
  }, 3000)

  function clickplay(){
    let btn = document.querySelector('.playandpause>span>i')
    if (document.querySelector('.playandpause>span>i').classList[1]=== 'fa-circle-play') {
      myInterval = setInterval(()=>{
        displapy(currentImageIndex)
        clickcircle(currentImageIndex+1)
        currentImageIndex++
      }, 3000)
      btn.classList.remove('fa-circle-play') 
      btn.classList.add('fa-circle-pause')
    }else{
      clearInterval(myInterval)
      btn.classList.remove('fa-circle-pause') 
      btn.classList.add('fa-circle-play')
    }
  }
