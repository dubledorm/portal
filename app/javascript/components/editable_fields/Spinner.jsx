import React from "react"

class Spinner extends React.Component {

    render () {
        return (
            <div className='rc-spinner'><i className="fa fa-spinner fa-spin"></i>{this.props.children}</div>
        )
    }
}

export default Spinner