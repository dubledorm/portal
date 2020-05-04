import React from "react"
import Spinner from "./Spinner"

class FieldTitle extends React.Component {
    render() {
        let button = null;

        if (!this.props.read_only) {
            if (this.props.spinner)
                button = <Spinner />;
            else
                button = <i className='fa fa-edit rc-fa-edit' onClick={this.props.onChangeMode.bind(this, true)} />;
        }

        return (
            <div className="rc-editable-field-title">
                <h2>{this.props.name}</h2>
                {button}
            </div>
        );
    }
}

export default FieldTitle
