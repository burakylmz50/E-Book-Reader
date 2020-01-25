(function () {
    var filejsonObj = [];

    $.each($("div.files-new div.row"), function () {
        var file_header = $(this).find("div.file-right h2").text();
        var file_pagecount = $(this).find("div.file-info .fi-pagecount").text();
        var file_year = $(this).find("div.file-info .fi-year").text();
        var file_size = $(this).find("div.file-info .fi-size").text();
        var file_hit = $(this).find("div.file-info .fi-hit").text();
        var file_lang = $(this).find("div.file-info .fi-lang").text();
        var file_imgsrc = $(location).attr("origin") + $(this).find("div.file-right a").attr("href");

        var file_jsonObj = {
            header: file_header,
            pagecount: file_pagecount,
            year: file_year,
            size: file_size,
            hit: file_hit,
            lang: file_lang,
            imgsrc: file_imgsrc
        };
        filejsonObj.push(file_jsonObj);
    })

    return filejsonObj;

})();

