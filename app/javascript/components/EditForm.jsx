import React from "react"
import PropTypes from "prop-types"

class EditForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {local_value: this.props.start_value, error_message: ''};

        this.onlocalChangeValue = this.onlocalChangeValue.bind(this);
        this.onSubmit = this.onSubmit.bind(this);
        this.onSubmitSuccess = this.onSubmitSuccess.bind(this);
        this.onSubmitError = this.onSubmitError.bind(this);
        this.onCancel = this.onCancel.bind(this);
    }

    onSubmit(event){
        $.ajax({
            type: "PUT",
            url: this.props.url,
            dataType: "json",
            data: $("#my_form").serialize(),
            //   data: `{this.props.resource_class: { name: this.state.local_value } }`,
            success: this.onSubmitSuccess,
            error: this.onSubmitError
        });
        event.preventDefault();
    }

    onSubmitSuccess(){
        this.setState({ error_message: '' });
        this.props.onChangeValue(this.state.local_value);
        this.props.onChangeMode(false);
    }

    onSubmitError(error){
        this.setState({ error_message: JSON.parse(error.responseText)[this.props.field_name]});
    }

    onCancel(event){
        this.props.onChangeMode(false);
        event.preventDefault();
    }

    onlocalChangeValue(event){
        this.setState({local_value: event.target.value});
    }


    render() {
        let error_message = '';
        if (this.state.error_message) {
            error_message = <div className="field_error">{this.state.error_message}</div>
        }

        let field_name = this.props.resource_class +'['+this.props.field_name+']';

        return (
            <div className="block-hidden-form1">
                <form onSubmit={this.onSubmit} id={'my_form'}>
                    <div className="form-group required">
                        <input type="text" name={field_name} className="form-control" value={this.state.local_value} onChange={this.onlocalChangeValue}/>
                        {error_message}
                        <div className="field_hint">{this.props.field_hint}</div>
                    </div>
                    <a className="btn btn-cancel" href="#" onClick={this.onCancel}>{this.props.cancel_button_text}</a>
                    <button className="btn btn-primary" name= "submit" required="required" type= "submit" >{this.props.submit_button_text}</button>

                </form>
            </div>);
    }
}

EditForm.propTypes = {
    start_value: PropTypes.string,
    field_name: PropTypes.string,
    field_hint: PropTypes.string,
    resource_class: PropTypes.string,
    url: PropTypes.string,
    cancel_button_text: PropTypes.string,
    submit_button_text: PropTypes.string,
    onChangeValue: PropTypes.func,
    onChangeMode: PropTypes.func
};

export default EditForm