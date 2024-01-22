$(()=>{
    //indicator
    let marker = $('.marker');
    let items = $('nav ul li');

    function indicator(e) {
        marker.css('left', e.offsetLeft + 'px');
        marker.css('width', e.offsetWidth + 'px');
    }

    items.each(function() {
        $(this).click(function(e) {
            indicator(e.target);
        });
    });

//scroll
    let nav = $('nav');

    $(window).scroll(function() {
        if ($(this).scrollTop() >= 20) {
            nav.addClass('nav');
        } else {
            nav.removeClass('nav');
        }

        if ($(this).scrollTop() >= 700) {
            nav.addClass('navBlack');
        } else {
            nav.removeClass('navBlack');
        }
    });

//menu
    let menuBx = $('#menu-box');
    let a = true;

    $('#menu').click(function() {
        // 클릭 이벤트 핸들러
        if (a == true) {
            menuBx.css('display', 'block');
            $(this).removeClass('fa-bars').addClass('fa-remove');
            a = false;
        } else {
            menuBx.css('display', 'none');
            $(this).removeClass('fa-remove').addClass('fa-bars');
            a = true;
        }
    });


    $(".carousel").owlCarousel({
        margin: 20,
        loop: true,
        autoplay: true,
        autoplayTimeout: 5000,
        autoplayHoverPause: true,
        responsive: {
            0:{
                items:3,
                nav: true
            },
            600:{
                items:3,
                nav: true
            },
            1000:{
                items:3,
                nav: true
            }
        }
    });

});



/*
const moviesList = [
  { movieName: "Tom and Jerry 2021", price: 7 },
  { movieName: "Master", price: 5 },
  { movieName: "Justice League", price: 4 },
];
*/

/*const selectMovieEl = document.getElementById("selectMovie");*/

const allSeatCont = document.querySelectorAll("#seatCont .seat");

const selectedSeatsHolderEl = document.getElementById("selectedSeatsHolder");

const moviePriceEl = document.getElementById("moviePrice");

const cancelBtnEL = document.getElementById("cancelBtn");

const proceedBtnEl = document.getElementById("proceedBtn");

/*$.each(moviesList, function(index, movie) {
  const optionEl = $("<option>").html(movie.movieName + " $" + movie.price);
  selectMovieEl.append(optionEl);
});*/


/*let moviePrice = 7;
let currentMovieName = `Tom and Jerry 2021`;

$(selectMovieEl).on("input", function(e) {
  let movieName = $(e.target).val().split("");
  let dollarIndex = movieName.indexOf("$");
  let movie = movieName.splice(0, dollarIndex - 1).join("");
  currentMovieName = movie;
  moviePrice = JSON.parse(movieName.splice(2, dollarIndex).join(""));

  updateMovieName(movie, moviePrice);
  updatePrice(moviePrice, takenSeats.length);
});*/


let initialSeatValue = 0;
allSeatCont.forEach((seat, index) => {
  seat.setAttribute("data-seatid", ++initialSeatValue);
});


const seatContEl = $("#seatCont .seat:not(.occupied)");

let takenSeats = [];

seatContEl.on("click", function() {
  let isSelected = $(this).hasClass("selected");

  let seatId = JSON.parse($(this).data("data-seatid"));

  if (!isSelected) {
    $(this).addClass("selected");
    takenSeats.push(seatId);
    takenSeats = [...new Set(takenSeats)];
  } else if (isSelected) {
    $(this).removeClass("selected");

    takenSeats = takenSeats.filter(function(seat) {
      return seat !== seatId;
    });
  }
  updateSeats();
  updatePrice(moviePrice, takenSeats.length);
});


function updateSeats() {
  selectedSeatsHolderEl.html("");

  $.each(takenSeats, function(index, seat) {
    const seatHolder = $("<div>").addClass("selectedSeat");
    selectedSeatsHolderEl.append(seatHolder);

    seatHolder.html(seat);
  });

  if (!takenSeats.length) {
    const spanEl = $("<span>").addClass("noSelected").html("NO SEAT SELECTED");
    selectedSeatsHolderEl.append(spanEl);
  }

  seatCount();
}


function seatCount() {
  const numberOfSeatEl = $("#numberOfSeat");
  numberOfSeatEl.html(takenSeats.length);
}


function updateMovieName(movieName, price) {
  const movieNameEl = $("#movieName");
  const moviePriceEl = $("#moviePrice");
  movieNameEl.html(movieName);
  moviePriceEl.html(`$ ${price}`);
}

function updatePrice(price, seats) {
  const totalPriceEl = $("#totalPrice");
  let total = seats * price;
  totalPriceEl.html(`$ ${total}`);
}


$("#cancelBtn").on("click", function(e) {
  cancelSeats();
});

function cancelSeats() {
  takenSeats = [];
  seatContEl.each(function(index, seat) {
    $(seat).removeClass("selected");
  });
  updatePrice(0, 0);
  updateSeats();
}


function successModal(movieNameIn, totalPrice, successTrue) {
  const bodyEl = $("body");
  const sectionEl = $("#section");

  const overlay = $("<div>").addClass("overlay");
  sectionEl.append(overlay);

  const successModal = $("<div>").addClass("successModal");
  const modalTop = $("<div>").addClass("modalTop");
  const popImg = $("<img>").attr("src", "https://github.com/Dinesh1042/Vanilla-JavaScript-Projects/blob/main/Movie%20Booking/asset/pop.png?raw=true");
  modalTop.append(popImg);
  successModal.append(modalTop);

  // Modal Center

  const modalCenter = $("<div>").addClass("modalCenter");
  const modalHeading = $("<h1>").html("Ticked Booked Successfully");
  modalCenter.append(modalHeading);
  const modalPara = $("<p>").html(`${movieNameIn} movie ticket has been booked successfully.`);
  modalCenter.append(modalPara);
  successModal.append(modalCenter);

  // Modal Bottom

  const modalBottom = $("<div>").addClass("modalBottom");
  const successBtn = $("<button>").html("Ok Got It!");
  modalBottom.append(successBtn);
  successModal.append(modalBottom);

  successBtn.on("click", function(e) {
    removeModal();
  });

  $(window).on("click", function(e) {
    if ($(e.target).hasClass("overlay")) {
      removeModal();
    }
  });

  function removeModal() {
    overlay.remove();
    successModal.remove();
    bodyEl.removeClass("modal-active");
    cancelSeats();
  }

  sectionEl.append(successModal);
}

$("#proceedBtnEl").on("click", function(e) {
  if (takenSeats.length) {
    const bodyEl = $("body");
    bodyEl.addClass("modal-active");
    successModal(currentMovieName, moviePrice * takenSeats.length);
  } else {
    alert("Oops no seat selected");
  }
});


seatContEl.each(function() {
  $(this).on("click", function(e) {
    let isSelected = $(this).hasClass("selected");

    let seatId = JSON.parse($(this).data("seatid"));

    if (!isSelected) {
      $(this).addClass("selected");
      takenSeats.push(seatId);
      takenSeats = [...new Set(takenSeats)];
    } else if (isSelected) {
      $(this).removeClass("selected");

      takenSeats = takenSeats.filter(function(seat) {
        return seat !== seatId;
      });
    }
    updateSeats();
    updatePrice(moviePrice, takenSeats.length);

    // 업데이트된 좌석에 대한 스타일을 추가/제거
    updateSeatStyles();
  });
});

// 모든 좌석에 대해 초기화
allSeatCont.each(function() {
  $(this).removeClass("selected");
});


 // 선택된 좌석에 대해 스타일 추가
 $.each(takenSeats, function(index, seatId) {
   const selectedSeat = $(`.seat[data-seatid="${seatId}"]`);
   if (selectedSeat.length) {
     selectedSeat.addClass("selected");
   }
 });

// 회원가입
 function handleEmailOption() {
                var emailOption = document.getElementById("emailOption");
                var emailInput = document.getElementById("emailAdr");

                if (emailOption.value === "input") {
                    emailInput.style.display = "block";
                } else {
                    emailInput.style.display = "none";
                }
            }

        const emailOptions = document.getElementById('emailOption');
        const emailInput = document.getElementById('emailAdr');

        emailOption.addEventListener('change', function() {
            if (emailOption.value === 'input') {
                emailInput.value = '';
                emailInput.disabled = false;
            } else {
                emailInput.value = emailOption.value;
                emailInput.disabled = true;
            }
        });
