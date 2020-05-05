import React from "react"
import PropTypes from "prop-types"
import ImageUpload from "./ImageUpload";
import BtnCancel from "./BtnCancel"
import BtnPrimary from "./BtnPrimary";
import RcSquareImage from "./RcSquareImage"
import Avatar from "./Avatar"



class BaseEditableImage extends React.Component {
    constructor(props) {
        super(props);
        this.onChangeModeHandler = this.onChangeModeHandler.bind(this);
        this.onSelectFileHandler = this.onSelectFileHandler.bind(this);
        this.onSubmitHandler = this.onSubmitHandler.bind(this);
        this.onSubmitSuccess = this.onSubmitSuccess.bind(this);
        this.onSubmitError = this.onSubmitError.bind(this);
        this.onStartLoader = this.onStartLoader.bind(this);


        this.state = {
            spinner: false,
            file: '',
            value: props.image_path,
            new_value: null,
            edit_mode: false,
            error_message: '',
            read_only: 'read_only' in props ? props.read_only : false
        }
    }

    // Нажатие на кнопку Cancel или на галку редактирования
    onChangeModeHandler(edit_mode) {

        this.setState(function(state, props) {
            if (state.edit_mode === edit_mode) {
                return {};
            } else {
                return {edit_mode: edit_mode, new_value: null, file: ''};
            }
        });
    }

    // Новый файл начал грузиться в ImageUpload
    onStartLoader() {
        this.setState({spinner: true});
    }

    // Завершение загрузки файла в ImageUploader
    onSelectFileHandler(value, new_image) {
        this.setState({file: value, new_value: new_image, spinner: false})
    }


    // Нажата кнопка 'Передать'
    onSubmitHandler() {
        if (this.state.file === '') {
            console.error('this.state.file is empty');
            return;
        }

        this.setState({spinner: true});

        let fd = new FormData;

        fd.append(`${this.props.resource_class}[${this.props.name}]`, this.state.file);


        $.ajax({
            type: "PUT",
            url: this.props.url,
            dataType: "json",
            processData: false,
            contentType: false,
            data: fd,
            success: this.onSubmitSuccess,
            error: this.onSubmitError
        });
    }

    // Файл успешно передан
    onSubmitSuccess(event){
        if (this.props.name in event) {
            this.setState({value: event[this.props.name], file: '', edit_mode: false, error_message: '', new_value: null});
        } else {
            console.error('The submit response does not have parameter ' + this.props.name + '.')
        }
        this.setState({spinner: false});
    }

    // Ошибка передачи файла
    onSubmitError(error){
        let error_message = error.responseText || error.statusText;
        console.error(`Submit error. Status = ${error.status}. Message = ${error_message}`);
        this.setState({ error_message: error_message });
        this.setState({ spinner: false, new_value: null });
    }


    viewSelect() {
        let result = null;
        switch(this.props.view_type) {
            case 'avatar':
                result = <Avatar image_path={this.state.new_value === null ? this.state.value : this.state.new_value} spinner={this.state.spinner}/>;
                break;
            case 'image':
                result = <RcSquareImage image_path={this.state.new_value === null ? this.state.value : this.state.new_value} spinner={this.state.spinner}/>;
                break;
        }
        return (
            result
        )
    }

    render () {
        const edit_mode = !this.state.read_only && this.state.edit_mode;
        let edit_panel = null;
        let edit_button = this.props.read_only ? '' : <i className='fa fa-edit rc-fa-edit' onClick={this.onChangeModeHandler.bind(this, true)} />;

        if (edit_mode) {
            let btnSend = this.state.file ? <BtnPrimary onClickHandler={this.onSubmitHandler}>{this.props.submit_button_text}</BtnPrimary> : '';
            let error_message = this.state.error_message ? <div className="rc-field-error">{this.state.error_message}</div> : '';

            edit_panel = (
                <div>
                    <ImageUpload onSelectFileHandler={this.onSelectFileHandler} onStartLoadFileHandler={this.onStartLoader}/>
                    {error_message}
                    <div className='rc-form-buttons'>
                        <BtnCancel onClickHandler={this.onChangeModeHandler.bind(this, false)}>{this.props.cancel_button_text}</BtnCancel>
                        {btnSend}
                    </div>
                </div>
            );
        }

        return (
            <React.Fragment>
                <div className="rc-block-item" id={`${this.props.resource_class}_` + this.state.name}>
                    <div className="rc-block-content" >
                        <div className='rc-editable-avatar-cover'>
                            {this.viewSelect()}
                            {edit_button}
                            {edit_panel}
                        </div>
                    </div>
                </div>
            </React.Fragment>
        );
    }
}

BaseEditableImage.propTypes = {
    view_type: PropTypes.string,
    image_path: PropTypes.string,
    name: PropTypes.string,
    name_title: PropTypes.string,
    name_hint: PropTypes.string,
    resource_class: PropTypes.string,
    cancel_button_text: PropTypes.string,
    submit_button_text: PropTypes.string,
    edit_element_type: PropTypes.string,
    url: PropTypes.string,
    read_only: PropTypes.bool
};


export default BaseEditableImage
