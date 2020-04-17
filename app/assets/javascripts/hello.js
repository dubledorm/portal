function hello(name) {
    console.log("Hello " + name + "!");
}


$.ajaxSetup({
    headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
});
