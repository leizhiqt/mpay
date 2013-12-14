/*********************************************
 * JavaScript Timer Control for Internet
 * Copyright (C) 2010-2020 FreshFlower
 *
 * @author FreshFlower <wpt206@163.com>
 * @site http://www.zerosong.com/
 * @version 1.2
 *********************************************/

var JTC = (function () {

    var JTC = function () { },

    config = {
        //日期背景颜色与字体颜色 依次: 可选择; 今天; 鼠标移过; 不可选择
        dayBgColor: ['#BCF3B1', '#FF99FF', '#F9D23A', '#EFEFEF'],
        dayColor: ['#303136', '#303136', '#303136', '#6F6F6F'],
        format: 'yyyy-MM-dd',   //返回日期值的格式
        outObject: null,
        minDate: null,      //日期范围最小值
        maxDate: null,      //日期范围最小值
        ranged: 1,          //是否包含日期边界值: 0.不包含; 1.包含
        showClear: false,   //是否显示清空按钮
        today: null,
        bgDivID: 'JTC_BG_DIV',
        yearSpan: 'JTC_TheCurYear',
        yearSelectSpan: 'JTC_SelectYearLayer',
        yearSelectCtrl: 'JTC_SelectYearCtrl',
        monthSpan: 'JTC_TheCurMonth',
        monthSelectSpan: 'JTC_SelectMonthLayer',
        monthSelectCtrl: 'JTC_SelectMonthCtrl',
        dayPanelId: 'JTC_TheCurDay',
        clearButtonId: 'JTC_ClearButton'
    },

    trim = function (str) {
        return str.replace(/(\s*$)|(^\s*)/g, '');
    },

    $ = function (id, doc) {
        var doc = doc || document;
        return doc.getElementById(id);
    },

    $$ = function (name, doc) {
        var doc = doc || document;
        return doc.createElement(name);
    },

    browser = (function () {
        var ua = navigator.userAgent.toLowerCase();
        return {
            VERSION: parseInt(ua.match(/(msie|firefox|webkit|opera)[\/:\s](\d+)/) ? RegExp.$2 : '0'),
            IE: (ua.indexOf('msie') > -1 && ua.indexOf('opera') == -1),
            GECKO: (ua.indexOf('gecko') > -1 && ua.indexOf('khtml') == -1),
            WEBKIT: (ua.indexOf('applewebkit') > -1),
            OPERA: (ua.indexOf('opera') > -1)
        };
    })(),

    util = {
        today: function () {
            if (config.today != null) { return config.today; }
            return new Date();
        },

        createTable: function (doc) {
            var table = $$('table', doc);
            table.cellPadding = 0;
            table.cellSpacing = 0;
            table.border = 0;
            return table;
        },

        createButton: function (text, style, func, id) {
            var button = $$('input');
            button.setAttribute('type', 'button');
            button.value = text;
            if (id) { button.id = id; }
            util.setObjectStyle(button, style + 'cursor:pointer;border:0px;');
            button.onclick = func;
            return button;
        },

        createObject: function (tag, Id, style, title) {
            var obj = $$(tag); obj.id = Id;
            if (title) { obj.title = title; }
            util.setObjectStyle(obj, style);
            return obj;
        },

        copyConfig: function () {
            var arg = ['dayBgColor', 'dayColor', 'format', 'outObject', 'minDate', 'maxDate', 'ranged', 'showClear'];
            var set = {};
            for (var i = 0; i < arg.length; i++) { set[arg[i]] = config[arg[i]]; }
            config['set'] = set; return config['set'];
        },

        formatDate: function (date, format) {
            var lang = { 'M+': date.getMonth() + 1, 'd+': date.getDate() };
            if (/(y+)/.test(format)) {
                format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));
            }
            for (var key in lang) {
                if (new RegExp('(' + key + ')').test(format)) {
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? lang[key] : ('00' + lang[key]).substr(('' + lang[key]).length));
                }
            }
            return format;
        },

        getCoords: function (ev) {
            ev = ev || window.event;
            return { x: ev.clientX, y: ev.clientY };
        },

        getDocumentElement: function (doc) {
            doc = doc || document;
            return (doc.compatMode != "CSS1Compat") ? doc.body : doc.documentElement;
        },

        getScrollPos: function () {
            var x, y;
            if (browser.IE || browser.OPERA) {
                var el = this.getDocumentElement();
                x = el.scrollLeft;
                y = el.scrollTop;
            } else {
                x = window.scrollX;
                y = window.scrollY;
            }
            return { x: x, y: y };
        },

        getElementPos: function (el) {
            var x = 0, y = 0, x1 = 0, y1 = 0;
            if (el.getBoundingClientRect) {
                var box = el.getBoundingClientRect();
                var el = this.getDocumentElement();
                var pos = this.getScrollPos();
                x = box.left + pos.x - el.clientLeft;
                y = box.top + pos.y - el.clientTop;
            } else {
                x = el.offsetLeft;
                y = el.offsetTop;
                var parent = el.offsetParent;
                while (parent) {
                    x += parent.offsetLeft;
                    y += parent.offsetTop;
                    parent = parent.offsetParent;
                }
            }
            return { x: x, y: y };
        },

        setObjectStyle: function (obj, style) {
            obj.setAttribute('style', style);
            obj.style.cssText = style;
        },

        setDate: function (dateObj) {
            if (dateObj == null || dateObj == undefined) { return null; }
            var ret = null;
            var x = typeof (dateObj);
            try {
                if (x == 'string') {
                    ret = new Date(trim(dateObj).replace(/[^0-9: ]+/g, '/'));
                } else if (x == 'object') {
                    if (dateObj.getTime()) { ret = new Date(dateObj.getTime()); }
                }
            } catch (e) { ret = null; }
            return ret;
        },

        isLeapYear: function (year) {   //是否为闰年
            return (0 == year % 4 && ((year % 100 != 0) || (year % 400 == 0)))
        },

        isToday: function (yy, mm, dd) {
            var num = parseInt(util.formatDate(util.today(), 'yyyyMMdd'));
            mm = mm > 9 ? mm : '0' + mm;
            dd = dd > 9 ? dd : '0' + dd;
            var num2 = parseInt('' + yy + mm + dd);
            return num2 > num ? 1 : (num2 == num ? 0 : -1);
        },

        getMonthCount: function (yy, mm) {
            var count = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            var days = count[mm - 1];
            if (mm == 2 && util.isLeapYear(yy)) { days++; }
            return days;
        },

        getDateNumbers: function (date) {
            return { year: date.getFullYear(), month: date.getMonth() + 1, day: date.getDate() };
        },
        //检查日期范围,返回 {result: 0/1/2(无限制/有限制/全限制), min:1(当月最小日), max:20(当月最大日)};
        checkRange: function (yy, mm) {
            var res = { result: 0, min: 1, max: 0 };
            var set = config['set'];
            var xmin = set.minDate == null ? { year: 0, month: 0, day: 0} : util.getDateNumbers(set.minDate);
            var xmax = set.maxDate == null ? { year: 9999, month: 12, day: 31} : util.getDateNumbers(set.maxDate);

            if ((yy > xmax.year) || (yy == xmax.year && mm > xmax.month) ||
                (yy < xmin.year) || (yy == xmin.year && mm < xmin.month)) {
                res.result = 2; return res;
            }
            if (yy == xmax.year && mm == xmax.month && xmax.day <= util.getMonthCount(yy, mm)) {
                res.result = 1; res.max = xmax.day;
            }
            if (yy == xmin.year && mm == xmin.month && xmin.day > 1) {
                res.result = 1; res.min = xmin.day;
            }
            res.max = res.max > 0 ? res.max : util.getMonthCount(yy, mm);
            return res;
        }
    },

    events = {
        addEvent: function (el, event, listener) {
            if (el.addEventListener) {
                el.addEventListener(event, listener, false);
            } else if (el.attachEvent) {
                el.attachEvent('on' + event, listener);
            }
        },

        removeEvent: function (el, event, listener) {
            if (el.removeEventListener) {
                el.removeEventListener(event, listener, false);
            } else if (el.detachEvent) {
                el.detachEvent('on' + event, listener);
            }
        },

        setHeadTip: function (yy, mm) {
            $(config.yearSpan).innerHTML = yy + ' 年';
            $(config.monthSpan).innerHTML = mm + ' 月';
        },

        createDay: function (yy, mm) {
            events.setHeadTip(yy, mm);
            var RevealDay = new Array(37);
            for (var i = 0; i < 37; i++) { RevealDay[i] = ''; }

            var nday = 1;
            firstCount = new Date(yy, mm - 1, 1).getDay();
            for (var i = firstCount; nday <= util.getMonthCount(yy, mm); i++) {
                RevealDay[i] = nday; nday++;
            }

            var setStyles = function (_obj, _bgcolor, _daycolor, _cursor) {
                _obj.style.backgroundColor = _bgcolor;
                _obj.style.color = _daycolor;
                if (_cursor) { _obj.style.cursor = _cursor; }
            }

            var set = config['set'];
            var ckym = util.checkRange(yy, mm);
            for (var i = 0; i < 37; i++) {
                var obj = $(config.dayPanelId + i);
                obj.innerHTML = RevealDay[i];   //填充日期

                if (RevealDay[i] == '') {   //空白区的背景及鼠标样式
                    obj.style.backgroundColor = '#FFFFFF';
                    obj.style.cursor = 'default';
                    continue;
                }
                //设置背景色,前景色,鼠标样式
                var isDay = util.isToday(yy, mm, RevealDay[i]);
                var sub = (ckym.result == 0 || (ckym.result == 1 && RevealDay[i] >= ckym.min && RevealDay[i] <= ckym.max)) ? 0 : 3;
                if (ckym.result == 1 && sub == 0 && (ckym.min == RevealDay[i] || RevealDay[i] == ckym.max)) {
                    sub = set.ranged === 1 ? 0 : 3;
                }
                if (isDay == 0) {
                    setStyles(obj, set.dayBgColor[1], set.dayColor[1], sub == 3 ? 'default' : 'pointer');
                } else {
                    setStyles(obj, set.dayBgColor[sub], set.dayColor[sub], sub == 3 ? 'default' : 'pointer');
                }
                obj.axis = isDay;
                //添加事件
                obj.onmouseover = function () {
                    if (this.innerHTML == '') { return; }
                    if (this.style.cursor == 'pointer') {
                        setStyles(this, set.dayBgColor[2], set.dayColor[2]);
                    }
                };
                obj.onmouseout = function () {
                    if (this.innerHTML == '') { return; }
                    if (this.axis == '0') {
                        setStyles(this, set.dayBgColor[1], set.dayColor[1]);
                    } else if (this.style.cursor == 'pointer') {
                        setStyles(this, set.dayBgColor[0], set.dayColor[0]);
                    }
                };
                obj.onclick = function () {
                    if (this.style.cursor == 'pointer') {
                        events.tdDayClick(this.innerHTML);
                    }
                };
            }
        },

        clearText: function () {
            var obj = config['set'].outObject;
            if (obj.tagName.toLowerCase() == 'input') {
                obj.value = '';
            } else {
                obj.innerHTML = '';
            }
        },

        turnDays: function (targ, num) {
            events.hidenYearSelectCtrl();
            events.hiddenMonthSelectCtrl();
            var year, month;
            if (targ == 'd') {
                var tt = util.getDateNumbers(util.today());
                year = tt.year; month = tt.month;
            } else {
                year = parseInt($(config.yearSpan).innerHTML.match(/\d+/g));
                month = parseInt($(config.monthSpan).innerHTML.match(/\d+/g));
                var flag = num > 0 ? 1 : -1;
                if (targ === 'm') {
                    if (month == 1 && flag < 0) { year--; month = 12; }
                    else if (month == 12 && flag > 0) { year++; month = 1; }
                    else { month += flag; }
                } else {
                    year += flag;
                }
            }
            events.createDay(year, month);
        },

        beginToSelectYear: function () {
            events.hiddenMonthSelectCtrl();
            var year = $(config.yearSpan).innerHTML.match(/\d+/g);
            $(config.yearSpan).style.display = 'none';
            var obj = $(config.yearSelectSpan);

            var yearSelector = util.createObject('select', config.yearSelectCtrl, 'font-size:12px;width:50px;');
            obj.appendChild(yearSelector);
            yearSelector.onchange = events.hidenYearSelectCtrl;
            yearSelector.onblur = events.hidenYearSelectCtrl;
            for (var i = 2020; i >= 1960; i--) {
                var item = new Option(i, i);
                yearSelector.options.add(item);
            }
            yearSelector.value = year;
            obj.style.display = '';
        },

        hidenYearSelectCtrl: function () {
            var obj = $(config.yearSelectCtrl);
            if (obj == null || obj == undefined) { return; }
            var year = parseInt(obj.options[obj.selectedIndex].value);
            var month = parseInt($(config.monthSpan).innerHTML.match(/\d+/g));

            $(config.yearSelectSpan).innerHTML = '';
            $(config.yearSelectSpan).style.display = 'none';
            $(config.yearSpan).innerHTML = year;
            $(config.yearSpan).style.display = '';
            events.createDay(year, month);
        },

        beginToSelectMonth: function () {
            events.hidenYearSelectCtrl();
            var month = $(config.monthSpan).innerHTML.match(/\d+/g);
            $(config.monthSpan).style.display = 'none';
            var obj = $(config.monthSelectSpan);

            var monthSelector = util.createObject('select', config.monthSelectCtrl, 'font-size:12px;width:35px;');
            monthSelector.onchange = events.hiddenMonthSelectCtrl;
            monthSelector.onblur = events.hiddenMonthSelectCtrl;
            for (var i = 1; i <= 12; i++) {
                var item = new Option(i, i);
                monthSelector.options.add(item);
            }
            monthSelector.value = month;
            obj.appendChild(monthSelector);
            obj.style.display = '';
        },

        hiddenMonthSelectCtrl: function () {
            var obj = $(config.monthSelectCtrl);
            if (obj == null || obj == undefined) { return; }
            var month = parseInt(obj.options[obj.selectedIndex].value);
            var year = parseInt($(config.yearSpan).innerHTML.match(/\d+/g));
            $(config.monthSelectSpan).innerHTML = '';
            $(config.monthSelectSpan).style.display = 'none';
            $(config.monthSpan).innerHTML = month;
            $(config.monthSpan).style.display = '';
            events.createDay(year, month);
        },

        hideLayout: function () {
            var div = $(config.bgDivID);
            events.hiddenMonthSelectCtrl();
            events.hidenYearSelectCtrl();
            div.style.display = 'none';
            events.removeEvent(document, 'keydown', events.keyDown);
            events.removeEvent(document, 'mousedown', events.mouseDown);
        },

        show: function (top, left) {
            var div = $(config.bgDivID);
            if (div == null || div == undefined) {
                dialog();
                var startDay = util.getDateNumbers(util.today()); 
                events.createDay(startDay.year, startDay.month);
                div = $(config.bgDivID);
            }
            else {
                var year = parseInt($(config.yearSpan).innerHTML.match(/\d+/g));
                var month = parseInt($(config.monthSpan).innerHTML.match(/\d+/g));
                events.createDay(year, month);
            }
            $(config.clearButtonId).style.display = config['set'].showClear ? '' : 'none';

            div.style.top = top + 'px';
            div.style.left = left + 'px';
            div.style.display = 'block';
            events.addEvent(document, 'keydown', events.keyDown);
            events.addEvent(document, 'mousedown', events.mouseDown);
        },

        tdDayClick: function (num) {
            var year = parseInt($(config.yearSpan).innerHTML.match(/\d+/g));
            var month = parseInt($(config.monthSpan).innerHTML.match(/\d+/g));
            var date = new Date(year + '/' + month + '/' + num);
            var obj = config['set'].outObject, str = util.formatDate(date, config['set'].format);
            if (obj.tagName.toLowerCase() == 'input') {
                obj.value = str;
            } else {
                obj.innerHTML = str;
            }
            events.hideLayout();
        },

        keyDown: function (ev) {
            ev = ev || window.event;
            if (ev.keyCode == 27) { events.hideLayout(); }
        },

        mouseDown: function (ev) {
            var div = $(config.bgDivID);
            if (div.style.display == 'none') { return; }

            var ymFlag = 0;
            if ($(config.yearSelectCtrl)) { ymFlag = 1; }
            if ($(config.monthSelectCtrl)) { ymFlag = 1; }

            var minLeft, minTop, maxLeft, maxTop;
            var pos = util.getElementPos(div);
            minLeft = pos.x; minTop = pos.y;
            maxLeft = minLeft + 170;
            maxTop = minTop + 185;

            var scrol = util.getScrollPos();
            var mouse = util.getCoords(ev)
            var x = scrol.x + mouse.x;
            var y = scrol.y + mouse.y;
            if (ymFlag == 1) {
                if (x < minLeft || x > maxLeft) { events.hideLayout(); }
                return;
            }
            if (x < minLeft || x > maxLeft || y < minTop || y > maxTop) {
                events.hideLayout();
            }
        }
    },

    dialog = function () {

        this.getHeadPanel = function () {
            var table = util.createTable();
            var _style = 'width:100%;height:21px;';
            util.setObjectStyle(table, _style);

            var row = table.insertRow(0);
            var cell = row.insertCell(0);
            _style = 'width:20px; height:21px; cursor:pointer';
            var bnStyle = 'width:19px; height:21px;';
            util.setObjectStyle(cell, _style);
            cell.title = '往前翻 年';
            cell.appendChild(util.createButton('<<', bnStyle, function () { events.turnDays('y', -1); }));

            cell = row.insertCell(1);
            util.setObjectStyle(cell, _style);
            cell.title = '往前翻 月';
            cell.appendChild(util.createButton('<', bnStyle, function () { events.turnDays('m', -1); }));

            cell = row.insertCell(2);
            util.setObjectStyle(cell, 'width:50px; height:21px; text-align:right');
            var span = util.createObject('span', config.yearSpan, 'width:100%;cursor:pointer;', '点击这里选择年份');
            span.onclick = events.beginToSelectYear;
            cell.appendChild(span);
            cell.appendChild(util.createObject('span', config.yearSelectSpan, 'display:none; width:50px;'));

            cell = row.insertCell(3);
            util.setObjectStyle(cell, 'width:41px; height:21px; text-align:left');
            span = util.createObject('span', config.monthSpan, 'width:40px;cursor:pointer;padding-left:5px;', '点击这里选择月份');
            span.onclick = events.beginToSelectMonth;
            cell.appendChild(span);
            cell.appendChild(util.createObject('span', config.monthSelectSpan, 'display:none; width:40px;'));

            cell = row.insertCell(4);
            util.setObjectStyle(cell, _style);
            cell.title = '往后翻 月';
            cell.appendChild(util.createButton('>', bnStyle, function () { events.turnDays('m', 1); }));

            cell = row.insertCell(5);
            util.setObjectStyle(cell, _style);
            cell.title = '往后翻 年';
            cell.appendChild(util.createButton('>>', bnStyle, function () { events.turnDays('y', 1); }));

            return table;
        };

        this.getWeekPanel = function () {
            var table = util.createTable();
            util.setObjectStyle(table, 'width:100%;height:20px;font-size:12px;');
            table.cellSpacing = 1;
            var row = table.insertRow(0);
            var weekDay = ['日', '一', '二', '三', '四', '五', '六'];
            for (var i = 0; i < 7; i++) {
                var cell = row.insertCell(i);
                util.setObjectStyle(cell, 'width:22px;height:20px;background-color:#99cc00;text-align:center;');
                cell.innerHTML = weekDay[i];
            }
            return table;
        };

        this.getDayPanel = function () {
            var table = util.createTable();
            var _style = 'width:100%;font-size:12px;';
            util.setObjectStyle(table, _style);
            table.cellSpacing = 1;

            _style = 'width:22px;height:20px;text-align:center;font-weight:bold;line-height:16px;';
            var count = 0;
            for (var i = 0; i <= 5; i++) {
                var row = table.insertRow(i);
                for (var j = 0; j < 7; j++) {
                    var cell = row.insertCell(j);
                    util.setObjectStyle(cell, _style);
                    cell.id = config.dayPanelId + count;
                    cell.innerHTML = '';
                    if (count > 36) {
                        cell.colSpan = 5;
                        cell.style.textAlign = 'right';
                        cell.appendChild(util.createButton('清空', 'width:35px; height:20px;', events.clearText, config.clearButtonId));
                        cell.appendChild(util.createButton('今天', 'width:35px; height:20px;', function () { events.turnDays('d'); }));
                        cell.appendChild(util.createButton('关闭', 'width:35px; height:20px;', events.hideLayout));
                        break;
                    }
                    count++;
                }
            }
            return table;
        };

        var load = util.createTable();
        var _style = 'width:168px;height:185px;font-size:12px;background-color:#ffffff; position:absolute;border-collapse:collapse;';
        util.setObjectStyle(load, _style);
        load.border = 1;
        load.borderColor = '#858F5F';

        var row = load.insertRow(0);
        var cell = row.insertCell(0);
        cell.style.height = '22px';
        cell.appendChild(this.getHeadPanel());

        row = load.insertRow(1);
        cell = row.insertCell(0);
        cell.style.height = '20px';
        cell.appendChild(this.getWeekPanel());

        row = load.insertRow(2);
        cell = row.insertCell(0);
        cell.style.height = '120px';
        cell.appendChild(this.getDayPanel());

        var div = $$('div');
        div.id = config.bgDivID;
        _style = 'position:absolute; width:170px; height:185px;z-index:20000; font-size:12px;display:none;';
        util.setObjectStyle(div, _style);

        if (browser.IE && browser.VERSION < 7) {
            var iframe = $$('iframe');
            _style = 'position:absolute; width:170px; height:185px;z-index:-1;';
            util.setObjectStyle(iframe, _style);
            iframe.frameBorder = 0;
            iframe.scrolling = 'no';
            iframe.src = 'about:blank';
            div.appendChild(iframe);
        }
        div.appendChild(load);
        document.body.appendChild(div);
    };

    JTC.setday = function (args) {
        var theEvent = window.event;
        if (theEvent == undefined) {
            var caller = arguments.callee.caller;
            while (caller.caller != null) { caller = caller.caller; }
            theEvent = caller.arguments[0];
        }
        var obj = theEvent.srcElement ? theEvent.srcElement : theEvent.target;

        var x = util.copyConfig();
        if (args) {
            if (typeof (args) == 'string') {
                if ($(args) != null && $(args) != undefined) {
                    x.outObject = $(args);
                } else { x.outObject = obj; }
            }
            else if (typeof (args.outObject) == 'string') {
                if ($(args.outObject) != null && $(args.outObject) != undefined) {
                    x.outObject = $(args.outObject);
                } else { x.outObject = obj; }
            } else if (typeof (args.outObject) == 'object') {
                x.outObject = args.outObject;
            } else { x.outObject = obj; }

            x.showClear = (args.showClear || config.showClear) === false ? false : true;
            x.format = args.format || config.format;
            if (args.today) { JTC.setToday(args.today); }
            if (args.minDate != undefined || args.maxDate != undefined) {
                x.minDate = util.setDate(args.minDate);
                x.maxDate = util.setDate(args.maxDate);
                x.ranged = (args.ranged || config.ranged) === false ? 0 : 1;
            }
            if (args.readOnly === true) { x.outObject.readOnly = true; }
        } else {
            x.outObject = obj;
        }

        var pos = { top: obj.offsetTop, left: obj.offsetLeft, height: obj.clientHeight };
        while (obj = obj.offsetParent) {
            pos.top += obj.offsetTop;
            pos.left += obj.offsetLeft;
        }
        var objTop = (typeof (obj) == 'image') ? pos.top + pos.height : pos.top + pos.height + 5;
        events.show(objTop, pos.left);
    };

    JTC.setToday = function (dateObj) {
        config.today = util.setDate(dateObj);
    };

    JTC.setDateRange = function (minDate, maxDate, ranged) {
        config.minDate = util.setDate(minDate);
        config.maxDate = util.setDate(maxDate);
        config.ranged = ranged === false ? 0 : 1;
    };

    JTC.setDateFormat = function (format) {
        config.format = format || config.format;
    };
    return JTC;
})();
