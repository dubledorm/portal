function toggle_block_content(e) {
    var block_content = e.parents('.block-content');

    if ( block_content[0] == undefined ) {
        console.error('Coild not find the parent with class block-content');
        return;
    }


    block_content_id = block_content.attr('id');

    if ( block_content_id == undefined ) {
        console.error('Element with class block-content should has an ID');
        return;
    }

    var selector_str = ".block-hidden-form[data-params-block-id='" + block_content_id + "']";

    block_content.find('.block-visible-data').toggle();
    block_content.find(selector_str).toggle(300);
}

$(document).ready(function() {
    block_content_form_init();
});

function block_content_form_init() {
    $('.block-content .block-visible-data').on(
        'click',
        function(e) {
            toggle_block_content($(this));
        }
    );

    $('.block-content a.btn-cancel').on(
        'click',
        function(e) {
            e.preventDefault();
            toggle_block_content($(this));
        }
    );

    $('.block-hidden-form').on(
        'ajax:beforeSend',
        function(e) {
            toggle_block_content($(this));
        }
    );
}

//$(document).click(function(e){ console.log($(e.target).attr('id')) })