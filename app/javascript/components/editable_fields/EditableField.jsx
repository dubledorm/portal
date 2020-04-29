import React from "react"
import PropTypes from "prop-types"
import EditForm from "./EditForm";



class FieldTitle extends React.Component {
  render() {
    let button = this.props.read_only ? '' : <i className='fa fa-edit rc-fa-edit' onClick={this.props.onChangeMode.bind(this, true)} />;
    return (
      <div className="rc-editable-field-title">
        <h2>{this.props.name}</h2>
        {button}
      </div>
    );
  }
}

class FieldContent extends React.Component {
  constructor(props) {
    super(props);
  }


  createMarkup() {
    return {__html: this.props.content.split('\n').join('<br/>')};
  }

  render() {
    return <div className="rc-block-visible-data" dangerouslySetInnerHTML={this.createMarkup()} />;
  }
}



class EditableField extends React.Component {
  constructor(props) {
    super(props);
    this.onChangeModeHandler = this.onChangeModeHandler.bind(this);
    this.onChangeValueHandler = this.onChangeValueHandler.bind(this);
    this.state = { value: props.start_value,
        name_title: props.name_title,
        edit_mode: false,
        read_only: 'read_only' in props ? props.read_only : false
    }
  }

  onChangeModeHandler(edit_mode) {
    this.setState({edit_mode: edit_mode});
  }

  onChangeValueHandler(value) {
    this.setState({value: value});
  }

  render () {
    const edit_mode = !this.state.read_only && this.state.edit_mode;

    let context = null;
    if (edit_mode) {
      context = <EditForm submit_button_text={this.props.submit_button_text}
                          cancel_button_text={this.props.cancel_button_text}
                          field_name={this.props.name}
                          field_hint={this.props.name_hint}
                          resource_class={this.props.resource_class}
                          start_value={this.state.value}
                          url={this.props.url}
                          onChangeValue={this.onChangeValueHandler}
                          onChangeMode={this.onChangeModeHandler}
                          edit_element_type={this.props.edit_element_type} />;

    } else {
      context = <FieldContent content={this.state.value} />
    }

    return (
      <React.Fragment>
        <div className="rc-block-item" id={`${this.props.resource_class}_` + this.state.name}>
          <div className="rc-block-content" >
            <FieldTitle name={this.state.name_title} onChangeMode={this.onChangeModeHandler} read_only={this.state.read_only}/>
            {context}
          </div>
        </div>
      </React.Fragment>
    );
  }
}

EditableField.propTypes = {
  name: PropTypes.string,
  name_title: PropTypes.string,
  name_hint: PropTypes.string,
  resource_class: PropTypes.string,
  start_value: PropTypes.string,
  cancel_button_text: PropTypes.string,
  submit_button_text: PropTypes.string,
  edit_element_type: PropTypes.string,
  url: PropTypes.string,
  read_only: PropTypes.bool
};


export default EditableField
