<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<body>
    <header>
       <jsp:include page="layouts/header.jsp" />
    </header>
   <section id="section">
       <div class="container">
         <!-- leftCont -->
         <div class="leftCont">
           <div class="leftMainCont">
             <div class="legendContainer">
               <ul>
                 <li>
                   <div class="seat legend"></div>
                   <small>Available</small>
                 </li>
                 <li>
                   <div class="seat legend selected"></div>
                   <small>Selected</small>
                 </li>
                 <li>
                   <div class="seat legend occupied"></div>
                   <small>Occupied</small>
                 </li>
               </ul>
             </div>
             <!-- seat Container -->
             <div class="mainSeatCont">
               <div class="screen">
                 <small>SCREEN</small>
               </div>
               <div class="seatCont" id="seatCont">
                 <div class="seatRowCont1 seatRowCont">
                   <div class="row">
                     <div class="seat"></div>
                     <div class="seat occupied"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                   </div>
                   <div class="row">
                     <div class="seat"></div>
                     <div class="seat occupied"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                   </div>
                 </div>
                 <div class="seatRowCont2 seatRowCont">
                   <div class="row">
                     <div class="seat"></div>
                     <div class="seat occupied"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                   </div>
                   <div class="row">
                     <div class="seat"></div>
                     <div class="seat occupied"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                   </div>
                   <div class="row">
                     <div class="seat"></div>
                     <div class="seat occupied"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                   </div>
                   <div class="row">
                     <div class="seat"></div>
                     <div class="seat occupied"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                   </div>
                 </div>
                 <div class="seatRowCont3 seatRowCont">
                   <div class="row">
                     <div class="seat"></div>
                     <div class="seat occupied"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                   </div>
                   <div class="row">
                     <div class="seat"></div>
                     <div class="seat occupied"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                     <div class="seat"></div>
                   </div>
                 </div>
               </div>
             </div>
           </div>
         </div>
         <!-- Right Cont -->
         <div class="rightCont">
           <div class="confirmCont">
             <div class="rightTopCont">
               <!-- moviename -->

               <div class="movieInfo">
               <!--
                 <div class="selectMovie">
                   <label>
                     <p>Select Your Movie</p>
                     <select id="selectMovie"></select>
                   </label>
                 </div> -->
                 <div class="movieName">
                   <p>MOVIE NAME</p>
                   <h1 id="movieName">${movie.mvTitle}</h1>
                 </div>
                 <div class="moviePrice">
                   <p>MOVIE PRICE</p>
                   <h1 id="moviePrice">$ 7</h1>
                 </div>
                 <div class="dateCont">
                   <p>Date</p>
                   <p class="dateOn">Wed , 31th march</p>

                 </div>
               </div>
             </div>
             <div class="rightBottomCont">
               <div class="selectedSeatCont">
                 <p>SELECTED SEATS</p>
                 <div class="selectedSeatsHolder" id="selectedSeatsHolder">
                   <span class="noSelected">No Seat Selected</span>
                 </div>
               </div>
               <!-- Seat number and price -->

               <div class="numberOfSeatsCont">
                 <div class="numberOfSeatEl">
                   <p><span id="numberOfSeat">0</span> Seats(s)</p>
                 </div>
                 <div class="priceCont">
                   <p id="totalPrice">$ 0</p>
                 </div>
               </div>
               <!-- button Cont -->

               <div class="buttonCont">
                 <div class="cancelBtn">
                   <button id="cancelBtn">Cancel</button>
                 </div>
                 <div class="proceedBtnEl">
                   <button id="proceedBtn">Continue</button>
                 </div>
               </div>
             </div>
           </div>
         </div>
       </div>
     </section>
    <jsp:include page="layouts/footer.jsp" />