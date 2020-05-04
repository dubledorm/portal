import React from "react"
import PropTypes from "prop-types"

function ListItem(props) {
    let control = props.included ?
        <div className='pull-right' onClick={props.onClickListHandler}><i className="fa fa-check"/></div> :
        <div className='pull-right' onClick={props.onClickListHandler}><i className="fa fa-square-o"/></div>;
    let element = '';

    if (props.edit_mode) {
        element = <li className='rc-editable'>{props.title}{control}</li>
    } else {
        element = <li><span>{props.title}</span></li>
    }

    return (
        element
    )
}


class SimpleList extends React.Component {
    constructor(props) {
        super(props);
    }


    render() {
        let listObjectItems = JSON.parse(this.props.value);

        let listItemsArray = this.props.edit_mode ?
            listObjectItems :
            listObjectItems.filter(item => item.included);

        let listItems = listItemsArray.map((item) => <ListItem key={item.name}
                                                               id={item.name} title={item.title}
                                                               included={item.included}
                                                               edit_mode={this.props.edit_mode}
                                                               onClickListHandler={this.props.onClickListHandler.bind(this, item.name)}/>);

        return (
            <div className="rc-simple-list">
                <ul>
                    {listItems}
                </ul>
            </div>
        )
    }
}

SimpleList.propTypes = {
    value: PropTypes.string,
    edit_mode: PropTypes.bool,
    onClickListHandler: PropTypes.func
};

export default SimpleList
