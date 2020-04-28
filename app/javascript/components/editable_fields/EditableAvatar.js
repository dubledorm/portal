import React from "react"
import PropTypes from "prop-types"
import ImageUpload from "./ImageUpload";
import Avatar from "./Avatar"
import BtnCancel from "./BtnCancel"
import BtnPrimary from "./BtnPrimary";


class EditableAvatar extends React.Component {
  constructor(props) {
    super(props);
    this.onChangeModeHandler = this.onChangeModeHandler.bind(this);
//    this.onChangeValueHandler = this.onChangeValueHandler.bind(this);
    this.onSelectFileHandler = this.onSelectFileHandler.bind(this);
    this.onSubmitHandler = this.onSubmitHandler.bind(this);
    this.onSubmitSuccess = this.onSubmitSuccess.bind(this);
    this.onSubmitError = this.onSubmitError.bind(this);

    this.state = {
      file: '',
      value: props.image_path,
      edit_mode: false,
      read_only: 'read_only' in props ? props.read_only : false
    }
  }


  onChangeModeHandler(edit_mode) {
    this.setState({edit_mode: edit_mode});
  }

  // onChangeValueHandler(value) {
  //   this.setState({value: value});
  // }

  onSelectFileHandler(value) {
    this.setState({file: value})
  }

  onSubmitHandler() {
    if (this.state.file === '') {
      console.error('this.state.file is empty');
      return;
    }

    let fd = new FormData;

    fd.append('user[avatar]', this.state.file);


    $.ajax({
      type: "PUT",
      url: 'profile',
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
      this.setState({value: event.avatar, file: '', edit_mode: false});
    } else {
      console.error('The submit response does not have parameter avatar.')
    }
  }

  onSubmitError(error){
    let message = JSON.parse(error.responseText)
    console.error('Submit error. Message: ');
    // this.setState({ error_message: this.props.field_name in message ? message[this.props.field_name] : message});
  }
  render () {
    const edit_mode = !this.state.read_only && this.state.edit_mode;
    let content = null;

    if (edit_mode) {
      let btnSend = this.state.file === '' ? '' : <BtnPrimary onClickHandler={this.onSubmitHandler}>{this.props.submit_button_text}</BtnPrimary>;
      content = (
          <div className='rc-editable-avatar-cover'>
            <ImageUpload imagePreviewUrl={this.state.value} onSelectFileHandler={this.onSelectFileHandler}/>
            <BtnCancel onClickHandler={this.onChangeModeHandler.bind(this, false)}>{this.props.cancel_button_text}</BtnCancel>
            {btnSend}
          </div>
      );
    } else {
      let button = this.props.read_only ? '' : <i className='fa fa-edit rc-fa-edit' onClick={this.onChangeModeHandler.bind(this, true)} />;
      content = (
          <div className='rc-editable-avatar-cover'>
            <Avatar image_path={this.state.value}/>
            {button}
          </div>);
    }

    return (
      <React.Fragment>
        <div className="rc-block-item" id={`${this.props.resource_class}_` + this.state.name}>
          <div className="rc-block-content" >
            {content}
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
