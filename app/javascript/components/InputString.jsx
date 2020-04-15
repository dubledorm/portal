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

class SubmitButton extends React.Component {
  render() {
    return <button className="btn btn-primary" name= "submit" required="required" type= "submit" >{this.props.text}</button>;
  }
}

class EditForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {local_value: this.props.start_value};

    this.onChangeValue = this.onChangeValue.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
    this.onCancel = this.onCancel.bind(this);
  }

  onSubmit(event){
    this.props.onChangeValue(this.state.local_value);
    this.props.onChangeMode(false);
    event.preventDefault();
  }

  onCancel(event){
    this.props.onChangeMode(false);
    event.preventDefault();
  }

  onChangeValue(event){
    this.setState({local_value: event.target.value});
  }


  render() {
    return (
        <div className="block-hidden-form1">
          <form onSubmit={this.onSubmit}>
            <div className="form-group required">
              <input type="text" name="login" className="form-control" value={this.state.local_value} onChange={this.onChangeValue}/>
              <div className="field_hint">fdsdfng.dfng.dfn</div>
            </div>
            <a className="btn btn-cancel" href="#" onClick={this.onCancel}>Отменить</a>
            <button className="btn btn-primary" name= "submit" required="required" type= "submit" >{this.props.submit_button_text}</button>;

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
                          start_value={this.state.value}
                          onChangeValue={this.onChangeValueHandler}
                          onChangeMode={this.onChangeModeHandler}/>
    } else {
      context = <FieldContent content={this.state.value} onChangeMode={this.onChangeModeHandler} />
    }

    return (
      <React.Fragment>
        <div className="block-item" id={"article1_" + this.state.name}>
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
  record: PropTypes.object
};


export default InputString
