import React from "react"
import PropTypes from "prop-types"
import EditForm from "./EditForm";



class FieldTitle extends React.Component {
  render() {
    return <h2>{this.props.name}</h2>;
  }
}

class FieldContent extends React.Component {
  constructor(props) {
    super(props);
    this.clickHandler = this.clickHandler.bind(this);
  }

  clickHandler() {
    this.props.onChangeMode(true);
  }

  createMarkup() {
    return {__html: this.props.content};
  }

  render() {
    return <div className="block-visible-data" onClick={this.clickHandler} dangerouslySetInnerHTML={this.createMarkup()} />;
  }
}



class EditableField extends React.Component {
  constructor(props) {
    super(props);
    this.onChangeModeHandler = this.onChangeModeHandler.bind(this);
    this.onChangeValueHandler = this.onChangeValueHandler.bind(this);
    this.state = { value: props.start_value,
        name_title: props.name_title,
        edit_mode: false
    }
  }

  onChangeModeHandler(edit_mode) {
    this.setState({edit_mode: edit_mode});
  }

  onChangeValueHandler(value) {
    this.setState({value: value});
  }

  render () {
    const edit_mode = this.state.edit_mode;

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
      context = <FieldContent content={this.state.value} onChangeMode={this.onChangeModeHandler} />
    }

    return (
      <React.Fragment>
        <div className="block-item" id={"article_" + this.state.name}>
          <div className="block-content" >
            <FieldTitle name={this.state.name_title} />
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
  edit_element_type: PropTypes.string
};


export default EditableField
