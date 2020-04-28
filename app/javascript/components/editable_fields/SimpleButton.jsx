import React from "react"
import PropTypes from "prop-types";


class SimpleButton extends React.Component {
    constructor(props) {
        super(props);
        this.clickHandler = this.clickHandler.bind(this);
    }

    clickHandler(event) {
        event.preventDefault();
        this.props.onClickHandler();
    }

    render () {
        return (
            <a className={this.props.className} href="#" onClick={this.clickHandler}>{this.props.children}</a>
        )
    }
}

SimpleButton.propTypes = {
    className: PropTypes.string,
    onClickHandler: PropTypes.func
};

export default SimpleButton
