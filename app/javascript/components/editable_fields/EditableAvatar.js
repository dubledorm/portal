import React from "react"
import PropTypes from "prop-types"
import ImageUpload from "./ImageUpload";
import Avatar from "./Avatar"
import BtnCancel from "./BtnCancel"
import BtnPrimary from "./BtnPrimary";
import Spinner from "./Spinner";


class EditableAvatar extends React.Component {
  constructor(props) {
    super(props);
    this.onChangeModeHandler = this.onChangeModeHandler.bind(this);
    this.onSelectFileHandler = this.onSelectFileHandler.bind(this);
    this.onSubmitHandler = this.onSubmitHandler.bind(this);
    this.onSubmitSuccess = this.onSubmitSuccess.bind(this);
    this.onSubmitError = this.onSubmitError.bind(this);


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


  onChangeModeHandler(edit_mode) {

    this.setState(function(state, props) {
      if (state.edit_mode === edit_mode) {
        return {};
      } else {
        return {edit_mode: edit_mode, new_value: null, file: ''};
      }
    });
  }

  onSelectFileHandler(value, new_image) {
    this.setState({file: value, new_value: new_image})
  }


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
  onSubmitSuccess(event){
    if ('avatar' in event) {
      this.setState({value: event.avatar, file: '', edit_mode: false, error_message: '', new_value: null});
    } else {
      console.error('The submit response does not have parameter avatar.')
    }
    this.setState({spinner: false});
  }

  onSubmitError(error){
    let message = JSON.parse(error.responseText);
    console.error('Submit error. Message: ' + message);
    this.setState({ error_message: this.props.field_name in message ? message[this.props.field_name] : message});
    this.setState({spinner: false, new_value: null });
  }


  render () {
    const edit_mode = !this.state.read_only && this.state.edit_mode;
    let content = null;
    let button = this.props.read_only ? '' : <i className='fa fa-edit rc-fa-edit' onClick={this.onChangeModeHandler.bind(this, true)} />;

    if (this.state.spinner) {
      button = <Spinner/>;
    }

    if (edit_mode) {
      let btnSend = this.state.file === '' ? '' : <BtnPrimary onClickHandler={this.onSubmitHandler}>{this.props.submit_button_text}</BtnPrimary>;
      let error_message = '';
      if (this.state.error_message) {
        error_message = <div className="rc-field-error">{this.state.error_message}</div>
      }

      content = (
          <div>
            <ImageUpload imagePreviewUrl={this.state.value} onSelectFileHandler={this.onSelectFileHandler}/>
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
              <Avatar image_path={this.state.new_value === null ? this.state.value : this.state.new_value} />
              {button}
              {content}
            </div>
          </div>
        </div>
      </React.Fragment>
    );
  }
}

EditableAvatar.propTypes = {
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


export default EditableAvatar
