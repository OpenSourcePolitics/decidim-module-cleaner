$(() => {
    const $checkboxField = $("input[name='organization[delete_admin_logs]']");
    const $numberField = $("input[name='organization[delete_admin_logs_after]']").parent();

    $checkboxField.change(function() {
        if(this.checked) {
            $numberField.show();
        } else {
            $numberField.hide();
        }
    });
});
