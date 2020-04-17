import React from "react"
import PropTypes from "prop-types"


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

  render() {
    return <div className="block-visible-data" onClick={this.clickHandler}>{this.props.content}</div>;
  }
}


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
          data: {article: { name: this.state.local_value } },
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

    return (
        <div className="block-hidden-form1">
          <form onSubmit={this.onSubmit}>
            <div className="form-group required">
              <input type="text" name="login" className="form-control" value={this.state.local_value} onChange={this.onlocalChangeValue}/>
              {error_message}
              <div className="field_hint">{this.props.field_hint}</div>
            </div>
            <a className="btn btn-cancel" href="#" onClick={this.onCancel}>{this.props.cancel_button_text}</a>
            <button className="btn btn-primary" name= "submit" required="required" type= "submit" >{this.props.submit_button_text}</button>

          </form>
        </div>);
  }
}


class InputString extends React.Component {
  constructor(props) {
    super(props);
    this.onChangeModeHandler = this.onChangeModeHandler.bind(this);
    this.onChangeValueHandler = this.onChangeValueHandler.bind(this);
    this.state = { value: props.record[props.name],
      name: props.name,
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
                          start_value={this.state.value}
                          url={this.props.url}
                          onChangeValue={this.onChangeValueHandler}
                          onChangeMode={this.onChangeModeHandler}/>
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

InputString.propTypes = {
  name: PropTypes.string,
  name_title: PropTypes.string,
  name_hint: PropTypes.string,
  resource_class: PropTypes.string,
  record: PropTypes.object,
  cancel_button_text: PropTypes.string,
  submit_button_text: PropTypes.string
};


export default InputString
