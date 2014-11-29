var fixedX = -1; ////////// 레이어 X축 위치 (-1 : 버튼에 바로 아래에 표시)
var fixedY = -1; ////////////// 레이어 Y축 위치 (-1 : 버튼에 바로 아래에 표시)
var startAt = 0; ///////////// 일요일 표시 부분 / 0 : 일요일(일월화...) / 1 : 월요일(...금토일)
var showToday = 1; // 오늘 날자 표시 유무 - 0 : 감춤 / 1 : 보임
var imgDir = './'; // 이미지 디렉토리 - ./ : 현재 디렉토리

/////////////////////////////// 각 변수 선언 ///////////////////
var crossobj, crossMonthObj, crossYearObj, monthSelected, yearSelected, dateSelected, omonthSelected, oyearSelected, odateSelected, monthConstructed, yearConstructed, intervalID1, intervalID2, timeoutID1, timeoutID2, ctlToPlaceValue, ctlNow, dateFormat, nStartingMonth, nStartingYear

var bPageLoaded = false;
var ie = document.all;
var dom = document.getElementById;
var bShow = false;
var ns4 = document.layers;

var today = new	Date(); /////////////// 날자 변수 선언
var dateNow = today.getDate(); //////////////// 로컬 컴퓨터의 일(day)을 구함  
var monthNow = today.getMonth(); ///////////////// 로컬 컴퓨터의 월(month)을 구함
var yearNow = today.getYear(); ///////////////// 로컬 컴퓨터의 년(year)을 구함

var	monthName =	new	Array("1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월")
var	monthName2 =	new	Array("1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월")

if (startAt==0) {
	dayName = new Array	("일","월","화","수","목","금","토")
} else {
	dayName = new Array	("월","화","수","목","금","토","일")
}
var oPopup = window.createPopup();
var oPopBody = oPopup.document.body;
var strCalendar;
var cleft;
var ctop;

if(dom) {
	strCalendar = "<img src='' width=0 height=0>";
	strCalendar += "<style type='text/css'>";
	strCalendar += "td {font-size:12px; font-family:굴림; text-decoration:none; }";
	strCalendar += "A:link,A:active,A:visited{text-decoration:none;font-size:12PX;color:#333333;}";
	strCalendar += "A:hover {text-decoration:none; color:ff9900}";
	strCalendar += "font { font-size: 9pt; }";
	strCalendar += ".cnj_close {font-size:8pt;color:#000000; background-color:#EFEFEF; border-width:1; border-color:#808080; border-style:solid;cursor:hand;font-weight:bold;height:16px;width:16px;text-align:center;vertical-align:bottom}";
	strCalendar += ".cnj_close2 {font-size:8pt;color:#ff0000; background-color:#EFEFEF; border-width:1; border-color:#808080; border-style:solid;cursor:hand;font-weight:bold;height:16px;width:16px;text-align:center;vertical-align:bottom}";
	strCalendar += ".cnj_input {background-color:rgb(240,240,240);border-width:1pt; height:16pt;cursor:hand;}";
	strCalendar += ".cnj_input2 {font-size:8pt;color:#808080; background-color:#EFEFEF; border-width:1; border-color:#808080; border-style:solid;cursor:hand;height:16px;}";
	strCalendar += ".cnj_input3 {font-size:8pt;color:#000000; background-color:#FFFFFF; border-width:1; border-color:#C00000; border-style:solid;cursor:hand;height:16px;}";
	strCalendar += ".cnj_input4 {font-size:8pt;color:#C00000; background-color:#FFFFFF; border-width:1; border-color:#808080; border-style:solid;cursor:hand;height:16px;}";
	strCalendar += ".cnj_td {border-width:1;border-style:solid;border-color:#a0a0a0;}";
	strCalendar += "</style>";

	strCalendar += "<div id='calendar' style='z-index:+999;position:absolute;;'>";
	strCalendar += "<table width='190' class='cnj_td'>";
	strCalendar += "	<tr bgcolor='#EEEEEE' height=20>";
	strCalendar += "		<td>";
	strCalendar += "			<table width='188' border=0>";
	strCalendar += "				<tr height=20>";
	strCalendar += "					<td style='padding:0px;'><font color='#ffffff'><B><span id='caption'></span></B></font></td>";
	strCalendar += "					<td align=right><input type='button' value='x' class='cnj_close' title='닫기' onclick='parent.oPopup.hide()' onfocus='this.blur()' onMouseover=\"this.className='cnj_close2'\" onMouseout=\"this.className='cnj_close'\"></td>";
	strCalendar += "				</tr>";
	strCalendar += "			</table>";
	strCalendar += "		</td>";
	strCalendar += "	</tr>";
	strCalendar += "	<tr height=1>";
	strCalendar += "		<td style='padding:3px' bgcolor=#ffffff><span id='content'></span></td>";
	strCalendar += "	</tr>";
			
	if(showToday==1) {
		strCalendar += "<tr bgcolor=#f0f0f0 height=20><td style='padding:5px' align=center><span id='lblToday'></span></td></tr>";
	}
			
	strCalendar += "</table>";
	strCalendar += "</div>";
	strCalendar += "<div id='selectMonth' style='z-index:+999;position:absolute;display:none;'></div> ";
	strCalendar += "<div id='selectYear' style='z-index:+999;position:absolute;display:none;'></div>";
	oPopBody.innerHTML = strCalendar;
}

function init() {
	if(!ns4) {
		if(!ie) {
			yearNow += 1900;
		}

		crossobj = oPopBody.all.calendar;
		crossMonthObj = oPopBody.all.selectMonth;
		crossYearObj = oPopBody.all.selectYear;
		monthConstructed = false;
		yearConstructed = false;

		sHTML1="<input type='button' value='◀' class='cnj_input2' onClick='javascript:parent.movedecMonth()' onfocus='this.blur()' title='이전 달로 이동' " 
		sHTML1+="onMouseover=\"this.className='cnj_input3';window.status='이전 달로 이동'\" onMouseout=\"this.className='cnj_input2';window.status=''\"> </span> "

		sHTML1+="<input type='button' value='▶'  class='cnj_input2' onClick='javascript:parent.moveincMonth()' onfocus='this.blur()' title='다음 달로 이동' " 
		sHTML1+="onMouseover=\"this.className='cnj_input3';window.status='다음 달로 이동'\"  onMouseout=\"this.className='cnj_input2';window.status=''\"> </span> "

		sHTML1+="<span id='spanMonth'  class='cnj_input4' onclick='parent.popUpMonth()' title='월 선택' "
		sHTML1+="onMouseover=\"this.className='cnj_input3';window.status='월 선택'\" onMouseout=\"this.className='cnj_input4';window.status=''\"></span>&nbsp;";

		sHTML1+="<span id='spanYear'  class='cnj_input4' onclick='parent.popUpYear()' title='년도 선택' "
		sHTML1+="onMouseover=\"this.className='cnj_input3';window.status='년도 선택'\" onMouseout=\"this.className='cnj_input4';window.status=''\"></span> ";

		oPopup.document.getElementById("caption").innerHTML = sHTML1;
		bPageLoaded = true;
		
		if(showToday==1) {
			oPopup.document.getElementById("lblToday").innerHTML =	""+
			"<div onmousemove='window.status=\"오늘 날짜\"' onmouseout='window.status=\"\"' title='오늘 날짜' "+
			//" style='"+styleAnchor+"' href='javascript:monthSelected=monthNow;yearSelected=yearNow;constructCalendar();' onFocus='this.blur()'>"+
			" style='"+styleAnchor+"' onclick=parent.totoday() onFocus='this.blur()'>"+
			"오늘 날짜 :  "+yearNow+"년 "+
			""+monthName[monthNow].substring(0,3)+" "+
			""+dateNow+"일 "+  // 일
			"</div>";
		}		
	}
}

function totoday(){ // 오늘 날짜로 표시하기
	monthSelected=monthNow;
	yearSelected=yearNow;
	constructCalendar();
}

function HolidayRec(d, m, y, desc) {
	this.d = d;
	this.m = m;
	this.y = y;
	this.desc = desc;
}

var HolidaysCounter = 0;
var Holidays = new Array();

function addHoliday(d, m, y, desc) {
	Holidays[HolidaysCounter++] = new HolidayRec ( d, m, y, desc );
}

var styleAnchor = "text-decoration:none;color:black;cursor:hand;width:100%;height:100%";
var styleLightBorder = "border-style:solid;border-width:1px;border-color:#a0a0a0;text-decoration:underline;font-weight:bold;cursor:hand;width:100%;height:100%";

function padZero(num) {
	return (num < 10)? '0' + num : num;
}

function constructDate(d,m,y) {
	sTmp = dateFormat
	sTmp = sTmp.replace("dd","<e>");
	sTmp = sTmp.replace("d","<d>");
	sTmp = sTmp.replace("<e>",padZero(d));
	sTmp = sTmp.replace("<d>",d);
	sTmp = sTmp.replace("mmmm","<p>");
	sTmp = sTmp.replace("mmm","<o>");
	sTmp = sTmp.replace("mm","<n>");
	sTmp = sTmp.replace("m","<m>");
	sTmp = sTmp.replace("<m>",m+1);
	sTmp = sTmp.replace("<n>",padZero(m+1));
	sTmp = sTmp.replace("<o>",monthName[m]);
	sTmp = sTmp.replace("<p>",monthName2[m]);
	sTmp = sTmp.replace("yyyy",y);

	return sTmp.replace("yy",padZero(y%100));
}

function closeCalendar() {
	oPopup.hide();
	ctlToPlaceValue.value =	constructDate(dateSelected,monthSelected,yearSelected);
}

function moveincMonth() {
	monthSelected++;

	if (monthSelected>11) {
		monthSelected=0;
		yearSelected++;
	}
	constructCalendar();
}

function movedecMonth() {
	monthSelected--;

	if (monthSelected<0) {
		monthSelected=11;
		yearSelected--;
	}
	constructCalendar();
}

function incMonth() {
	if (nStartingMonth + 6 == 12) return;
	for(i = 0; i < 7; i++) {
		newMonth = (i + nStartingMonth) + 1;

		if (newMonth > 12) {nStartingMonth--; break;}
		if (newMonth == monthSelected + 1) {
			txtMonth = " <b>"+ newMonth +"월</b> "; 
		} else {
			txtMonth = " " + newMonth + "월"; 
		}
		oPopup.document.getElementById("m"+i).innerHTML = txtMonth;
	}
	nStartingMonth++;
	bShow = true;
}

function decMonth() {
	if (nStartingMonth == 1) return;
	for (i=0; i<7; i++) {
		newMonth	= (i+nStartingMonth)-1;

		if (newMonth < 1) {nStartingMonth++; break;}
		if (newMonth==monthSelected + 1) {
			txtMonth = " <b>"+ newMonth +"월</b> "; 
		} else {
			txtMonth = " " + newMonth + "월"; 
		}
		oPopup.document.getElementById("m"+i).innerHTML = txtMonth;
	}
	nStartingMonth--;
	bShow = true;
}

function selectMonth(nMonth) {
	monthSelected = parseInt(nMonth + nStartingMonth - 1);
	monthConstructed = false;
	constructCalendar();
	popDownMonth();
}

function constructMonth() {
	popDownYear();
	sHTML =	"";

	if(!monthConstructed) { // 월 이전 월 링크
		sHTML ="<tr><td align='center' style='cursor:pointer'	 "
		sHTML +="	onmouseover='this.style.backgroundColor=\"#FFCC99\"' "
		sHTML +="	onmouseout='clearInterval(parent.intervalID1);this.style.backgroundColor=\"\"'  "
		sHTML +="	onmousedown='clearInterval(parent.intervalID1);parent.intervalID1=setInterval(\"parent.decMonth()\",30)' "
		sHTML +="	onmouseup='clearInterval(parent.intervalID1)'> "
		sHTML +="	▲</td></tr>";
		j = 0;
		
		var nSelectedMonth = monthSelected + 1;
		
		nStartingMonth = (nSelectedMonth - 3) < 1 ? 1 : nSelectedMonth - 3; //시작월 - 3 이 1보다 작으면 1로 고정
		nStartingMonth = nStartingMonth > 6 ? 6 : nStartingMonth; //시작월이 6보다 크면 6로 고정 (6 시작 월 + 목록 숫자 6 = 12 종료 월)

		var nEndMonth = (nSelectedMonth + 3) > 12 ? 12 : (nSelectedMonth + 3); // 종료월 + 3이 12보다 크면 12로 고정
		nEndMonth = nEndMonth < 7 ? 7 : nEndMonth; //종료 월이 7보다 작으면 7로 고정
		
		for (i = nStartingMonth; i <= nEndMonth; i++) {
			sName =	i;

			//////////////// 현재 월 ////////////////////////
			if (i == nSelectedMonth) { sName = "<b>" + sName + "</b>" }
			sHTML +="<tr><td height='15' id='m" + j + "' onmouseover='this.style.backgroundColor=\"#FFCC99\"' onmouseout='this.style.backgroundColor=\"\"' "
			sHTML +=" style='cursor:pointer' onClick='parent.selectMonth("+j+");event.cancelBubble=true'> " + sName + "월"
			sHTML +="</td></tr>";
			j ++;
		}
        
		 // 월 다음 월 링크
		sHTML += "<tr><td align='center' onmouseover='this.style.backgroundColor=\"#FFCC99\"' style='cursor:pointer' "
		sHTML += " onmouseout='clearInterval(parent.intervalID2);this.style.backgroundColor=\"\"' "
		sHTML += " onmousedown='clearInterval(parent.intervalID2);parent.intervalID2=setInterval(\"parent.incMonth()\",30)'	"
		sHTML += " onmouseup='clearInterval(parent.intervalID2)'> "
		sHTML += " ▼</td></tr>";

          /////// 월 표 크기 ///////////////////////////////
		oPopup.document.getElementById("selectMonth").innerHTML	= ""+
		"<table width='50' style='font-family:굴림; font-size:11px; border-width:1; border-style:solid; border-color:#a0a0a0;' bgcolor='#FFFFDD' "+ 
		" onmouseover='clearTimeout(parent.timeoutID2)' "+
		" onmouseout='clearTimeout(parent.timeoutID2);parent.timeoutID2=setTimeout(\"parent.popDownMonth()\",100)' cellspacing=0>"+
		""+ sHTML	+ ""+
		"</table>";
		monthConstructed	= true;
	}
}

function popUpMonth() {
	constructMonth();
	crossMonthObj.style.display = "";
	crossMonthObj.style.left = crossobj.style.left + 50;
	crossMonthObj.style.top = crossobj.style.top + 26;
}

function popDownMonth()	{
	crossMonthObj.style.display = "none";
}

function incYear() {
	for(i=0; i<7; i++) {
		newYear	= (i+nStartingYear)+1;

		if (newYear==yearSelected) {
			txtYear = " <B>"+ newYear +"년  </B> "; 
		} else {
			txtYear = " " + newYear + "년  "; 
		}
		oPopup.document.getElementById("y"+i).innerHTML = txtYear;
	}
	nStartingYear++;
	bShow = true;
}

function decYear() {
	for (i=0; i<7; i++) {
		newYear	= (i+nStartingYear)-1;

		if (newYear==yearSelected) {
			txtYear = " <b>"+ newYear +"년  </b> "; 
		} else {
			txtYear = " " + newYear + "년  "; 
		}
		oPopup.document.getElementById("y"+i).innerHTML = txtYear;
	}
	nStartingYear--;
	bShow = true;
}

function selectYear(nYear) {
	yearSelected = parseInt(nYear+nStartingYear);
	yearConstructed = false;
	constructCalendar();
	popDownYear();
}

function constructYear() {
	popDownMonth();
	sHTML =	"";

	if(!yearConstructed) { // 년도 이전 년도 링크
		sHTML ="<tr><td align='center' style='cursor:pointer'	 "
		sHTML +="	onmouseover='this.style.backgroundColor=\"#FFCC99\"' "
		sHTML +="	onmouseout='clearInterval(parent.intervalID1);this.style.backgroundColor=\"\"'  "
		sHTML +="	onmousedown='clearInterval(parent.intervalID1);parent.intervalID1=setInterval(\"parent.decYear()\",30)' "
		sHTML +="	onmouseup='clearInterval(parent.intervalID1)'> "
		sHTML +="	▲</td></tr>";
		j = 0;
		nStartingYear =	yearSelected-3;

		for (i=(yearSelected-3); i<=(yearSelected+3); i++) {
			sName =	i;

			if (i==yearSelected) { sName =	"<b>" +	sName +	"</b>" }
			sHTML +="<tr><td height='15' id='y" + j + "' onmouseover='this.style.backgroundColor=\"#FFCC99\"' onmouseout='this.style.backgroundColor=\"\"' "
			sHTML +=" style='cursor:pointer' onClick='parent.selectYear("+j+");event.cancelBubble=true'> " + sName + "년  "
			sHTML +="</td></tr>";
			j ++;
		}
        
		 // 년도 다음 년도 링크
		sHTML += "<tr><td align='center' onmouseover='this.style.backgroundColor=\"#FFCC99\"' style='cursor:pointer' "
		sHTML += " onmouseout='clearInterval(parent.intervalID2);this.style.backgroundColor=\"\"' "
		sHTML += " onmousedown='clearInterval(parent.intervalID2);parent.intervalID2=setInterval(\"parent.incYear()\",30)'	"
		sHTML += " onmouseup='clearInterval(parent.intervalID2)'> "
		sHTML += " ▼</td></tr>";

         /////// 년도 표 크기 ///////////////////////////////
		oPopup.document.getElementById("selectYear").innerHTML	= ""+
		"<table width='55' style='font-family:굴림; font-size:11px; border-width:1; border-style:solid; border-color:#a0a0a0;' bgcolor='#FFFFDD' "+ 
		" onmouseover='clearTimeout(parent.timeoutID2)' "+
		" onmouseout='clearTimeout(parent.timeoutID2);parent.timeoutID2=setTimeout(\"parent.popDownYear()\",100)' cellspacing=0>"+
		""+ sHTML	+ ""+
		"</table>";
		yearConstructed	= true;
	}
}

function popDownYear() {
	clearInterval(intervalID1);
	clearTimeout(timeoutID1);
	clearInterval(intervalID2);
	clearTimeout(timeoutID2);
	crossYearObj.style.display = "none";
}

function popUpYear() {
	constructYear();
	crossYearObj.style.display = "";
	crossYearObj.style.left = crossobj.style.left + (6 + oPopup.document.getElementById("spanYear").offsetLeft) + "px";
	crossYearObj.style.top = crossobj.style.top + 26;
}

function constructCalendar() {
	var aNumDays = Array (31,0,31,30,31,30,31,31,30,31,30,31);
	var dateMessage;
	var startDate =	new Date (yearSelected,monthSelected,1);
	var endDate;
	var intWeekCount = 1;
	
	if(monthSelected==1) {
		endDate	= new Date (yearSelected,monthSelected+1,1);
		endDate	= new Date (endDate	- (24*60*60*1000));
		numDaysInMonth = endDate.getDate();
	} else {
		numDaysInMonth = aNumDays[monthSelected];
	}

	datePointer = 0;
	dayPointer = startDate.getDay() - startAt;
		
	if(dayPointer<0) {
		dayPointer = 6;
	}
	sHTML =	"<table	 border=0 style='font-family:verdana;font-size:10px;'><tr height=16>";

	for(i=0; i<7; i++) {   /////// 요일 ///////////////////////
		if(i == 0) {
			sHTML += "<td width='27' align='right'><b><font color=red>"+ dayName[i]+"</font></b></td>";
		} else if(i == 6) {
			sHTML += "<td width='27' align='right'><b><font color=blue>"+ dayName[i]+"</font></b></td>";
		} else {
			sHTML += "<td width='27' align='right'><b>"+ dayName[i]+"</b></td>";
		}
	}
	sHTML +="</tr><tr height=16>";
		
	for(var i=1; i<=dayPointer;i++)	{  // 빈 날짜
		sHTML += "<td> </td>";
	}
	
	for(datePointer=1; datePointer<=numDaysInMonth; datePointer++) {
		dayPointer++;
		sHTML += "<td align=right>";
		sStyle = styleAnchor;

		if((datePointer==odateSelected) && (monthSelected==omonthSelected) && (yearSelected==oyearSelected)) {
			sStyle += styleLightBorder;
		}
		sHint = "";

		for(k=0;k<HolidaysCounter;k++) {
			if((parseInt(Holidays[k].d)==datePointer)&&(parseInt(Holidays[k].m)==(monthSelected+1))) {
				if((parseInt(Holidays[k].y)==0)||((parseInt(Holidays[k].y)==yearSelected)&&(parseInt(Holidays[k].y)!=0))) {
					sStyle+="background-color:#FFDDDD;";
					sHint+=sHint==""?Holidays[k].desc:"\n"+Holidays[k].desc;
				}
			}
		}
		var regexp= /\"/g;
		sHint=sHint.replace(regexp,"&quot;");
		/////////////// 날짜 선택시 ==> 마우스가 날짜 위로 갔을때 ///////////////////////////////
		dateMessage = "title=' 날짜 선택 : "+ yearSelected + "년 " +	monthName[monthSelected] +" "  + datePointer + "일"+"' onmousemove='window.status=\" 날짜 선택 : "+ yearSelected + "년 " +	monthName[monthSelected] +" "  + datePointer + "일"+"\"' onmouseout='window.status=\"\"' ";

		if((datePointer == dateNow) && (monthSelected == monthNow) && (yearSelected == yearNow)) {  // 현재 오늘 날짜
			sHTML += "<b><div style='"+sStyle+"' onclick='javascript:parent.dateSelected="+datePointer+";parent.closeCalendar();'><font color=#00C000> " + datePointer + "</font> </div></b>";
		} else
		//if((dayPointer % 7 == (startAt * -1)+1) || (dayPointer % 7 == (startAt * -1))) {  // 일요일, 토요일
		if(dayPointer % 7 == ((startAt * -1)+1)) {  // 일요일
			sHTML += "<div style='"+sStyle+"' onclick='javascript:parent.dateSelected="+datePointer + ";parent.closeCalendar();'> <font color=red>" + datePointer + "</font> </div>";
		} else if(dayPointer % 7 == (startAt * -1)) { // 토요일
			sHTML += "<div style='"+sStyle+"' onclick='javascript:parent.dateSelected="+datePointer + ";parent.closeCalendar();'> <font color=blue>" + datePointer + "</font> </div>";
		} else {
			sHTML += "<div style='"+sStyle+"' onclick='javascript:parent.dateSelected="+ datePointer + ";parent.closeCalendar();'>" + datePointer + "</div>";
		}
		sHTML += "";

		if((dayPointer+startAt) % 7 == startAt) { 
			sHTML += "</tr><tr height=16>";
			intWeekCount ++;
		}
	}
	sHTML += "</tr>";
	sHTML = sHTML.replace("<tr height=16></tr>", "");
	if (((dayPointer+startAt) % 7) == 0) intWeekCount--;
	oPopup.document.getElementById("content").innerHTML = sHTML;  
	//////// 셀릭트 월 선택
	oPopup.document.getElementById("spanMonth").innerHTML = " " +	monthName[monthSelected] + " <input type='button'  id='changeMonth'value='▼'  class='cnj_input2' onfocus='this.blur()' onMouseover=\"this.className='cnj_input3'\" onMouseout=\"this.className='cnj_input2'\">"

	//////// 셀릭트 년도 선택
	oPopup.document.getElementById("spanYear").innerHTML =	" " + yearSelected	+ "년 <input type='button'  id='changeYear'' value='▼'  class='cnj_input2' onfocus='this.blur()' onMouseover=\"this.className='cnj_input3'\" onMouseout=\"this.className='cnj_input2'\">"

	//alert(intWeekCount);
	var popHeight;
	if (intWeekCount == 6)
		popHeight = 195;
	else
		popHeight = 177;
	oPopup.show(cleft, ctop, 198, popHeight, document.body);
}

function popUpCalendar(ctl, ctl2, format) {
	var leftpos = 0;
	var toppos = 0;

	if(bPageLoaded) {
		ctlToPlaceValue	= ctl2;
		dateFormat=format;
		formatChar = " ";
		aFormat	= dateFormat.split(formatChar);

			if(aFormat.length<3) {
				formatChar = "/";
				aFormat	= dateFormat.split(formatChar);

				if(aFormat.length<3) {
					formatChar = ".";
					aFormat	= dateFormat.split(formatChar);

					if(aFormat.length<3) {
						formatChar = "-";
						aFormat	= dateFormat.split(formatChar);

						if (aFormat.length<3) {
							formatChar="";
						}
					}
				}
			}
			tokensChanged =	'0';

			if(formatChar != "") {
				aData =	ctl2.value.split(formatChar);

				for(i=0;i<3;i++) {
					if ((aFormat[i]=="d") || (aFormat[i]=="dd")) {
						dateSelected = parseInt(aData[i], 10);
						tokensChanged++;
					} else
					if((aFormat[i]=="m") || (aFormat[i]=="mm")) {
						monthSelected =	parseInt(aData[i], 10) - 1;
						tokensChanged++;
					} else
					if(aFormat[i]=="yyyy") {
						yearSelected = parseInt(aData[i], 10);
						tokensChanged++;
					}else
					if(aFormat[i]=="mmm") {

						for(j=0; j<12;	j++) {
							if (aData[i]==monthName[j]) {
								monthSelected=j;
								tokensChanged++;
							}
						}
					} else
					if(aFormat[i]=="mmmm") {
						for(j=0; j<12;	j++) {
							if (aData[i]==monthName2[j]) {
								monthSelected=j;
								tokensChanged ++;
							}
						}
					}
				}
			}

			if((tokensChanged!=3) || isNaN(dateSelected) || isNaN(monthSelected) || isNaN(yearSelected)) {
				dateSelected = dateNow;
				monthSelected =	monthNow;
				yearSelected = yearNow;
			}
			odateSelected=dateSelected;
			omonthSelected=monthSelected;
			oyearSelected=yearSelected;

			aTag = ctl;
			do {
				aTag = aTag.offsetParent;
				leftpos	+= aTag.offsetLeft;
				toppos += aTag.offsetTop;
			} while(aTag.tagName!="BODY");

			cleft =	fixedX==-1 ? ctl.offsetLeft	+ leftpos :	fixedX;
			ctop = fixedY==-1 ?	ctl.offsetTop +	ctl.offsetHeight + toppos :	fixedY;
			constructCalendar (1, monthSelected, yearSelected);

			bShow = true;
			ctlNow = ctl;
		}
	}

init();


