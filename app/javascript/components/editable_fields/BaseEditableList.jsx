import React from "react"
import PropTypes from "prop-types"
import BtnCancel from "./BtnCancel"
import BtnPrimary from "./BtnPrimary";
import SimpleList from "./SimpleList"
import FieldTitle from "./FieldTitle"



class BaseEditableList extends React.Component {
    constructor(props) {
        super(props);
        this.onChangeModeHandler = this.onChangeModeHandler.bind(this);
        this.onChangeValue = this.onChangeValue.bind(this);
        this.onSubmitHandler = this.onSubmitHandler.bind(this);
        this.onSubmitSuccess = this.onSubmitSuccess.bind(this);
        this.onSubmitError = this.onSubmitError.bind(this);


        this.state = {
            spinner: false,
            value: props.start_value,
            new_value: props.start_value,
            edit_mode: false,
            error_message: '',
            read_only: 'read_only' in props ? props.read_only : false
        }
    }

    // Нажатие на кнопку Cancel или на галку редактирования
    onChangeModeHandler(edit_mode) {

        this.setState(function(state) {
            if (state.edit_mode === edit_mode) {
                return {};
            } else {
                return {edit_mode: edit_mode, new_value: this.state.value};
            }
        });
    }


    static invertItem(item) {
        item.included = !item.included;

        return item;
    }

    // Изменение в редактируемом элементе
    onChangeValue(key) {
      // Находим элемент в списке и меняем его состояние
        this.setState(function(state) {
            let listObjectItems = JSON.parse(state.new_value);
            listObjectItems.categories = listObjectItems.categories.map((item) => key === item.name ? BaseEditableList.invertItem(item) : item );

            return {
                new_value: JSON.stringify(listObjectItems)
            };
        });
    }


    // Нажата кнопка 'Передать'
    onSubmitHandler() {
        this.setState({spinner: true});

        let fd = new FormData;

        fd.append(`${this.props.resource_class}[${this.props.name}]`, this.state.new_value);


        $.ajax({
            type: "PATCH",
            url: this.props.url,
            dataType: "json",
            processData: false,
            contentType: false,
            data: fd,
            success: this.onSubmitSuccess,
            error: this.onSubmitError
        });
    }

    // Изменения успешно переданы
    onSubmitSuccess(event){
        if (this.props.name in event) {
            let value = JSON.stringify(event);
            this.setState({value: value, edit_mode: false, error_message: '', new_value: value});
        } else {
            console.error('The submit response does not have parameter ' + this.props.name + '.')
        }
        this.setState({spinner: false});
    }

    // Ошибка передачи изменений
    onSubmitError(error){
        let error_message = error.responseText || error.statusText;
        console.error(`Submit error. Status = ${error.status}. Message = ${error_message}`);
        this.setState({ error_message: error.statusText });
        this.setState({ spinner: false });
    }


    viewSelect(edit_mode) {
        let result = null;

        result = <SimpleList value={this.state.new_value}
                             edit_mode={edit_mode}
                             onClickListHandler={this.onChangeValue}/>;
        // switch(this.props.view_type) {
        //     case 'simple_list':
        //         result = <SimpleList value={this.state.new_value === null ? this.state.value : this.state.new_value}
        //                              spinner={this.state.spinner} edit_mode={edit_mode} />;
        //         break;
        // }
        return (
            result
        )
    }

    render () {
        const edit_mode = !this.state.read_only && this.state.edit_mode;
        let edit_panel = null;

        if (edit_mode) {
            let error_message = this.state.error_message ? <div className="rc-field-error">{this.state.error_message}</div> : '';

            edit_panel = (
                <div>
                    {error_message}
                    <div className='rc-form-buttons'>
                        <BtnCancel onClickHandler={this.onChangeModeHandler.bind(this, false)}>{this.props.cancel_button_text}</BtnCancel>
                        <BtnPrimary onClickHandler={this.onSubmitHandler}>{this.props.submit_button_text}</BtnPrimary>
                    </div>
                </div>
            );
        }

        return (
            <React.Fragment>
                <div className="rc-block-item" id={`${this.props.resource_class}_` + this.props.name}>
                    <div className="rc-block-content" >
                        <FieldTitle name={this.props.name_title}
                                    onChangeMode={this.onChangeModeHandler}
                                    read_only={this.props.read_only}
                                    spinner={this.state.spinner} />
                        <div className='rc-editable-list-cover'>
                            {this.viewSelect(edit_mode)}
                            {edit_panel}
                        </div>
                    </div>
                </div>
            </React.Fragment>
        );
    }
}

BaseEditableList.propTypes = {
    start_value: PropTypes.string,
    view_type: PropTypes.string,
    name: PropTypes.string,
    name_title: PropTypes.string,
    name_hint: PropTypes.string,
    resource_class: PropTypes.string,
    cancel_button_text: PropTypes.string,
    submit_button_text: PropTypes.string,
    url: PropTypes.string,
    read_only: PropTypes.bool
};


export default BaseEditableList
