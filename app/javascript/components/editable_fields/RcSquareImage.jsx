import React from "react"
import Spinner from "./Spinner"


function RcSquareImage(props) {
    let imgStyle = props.image_path === undefined ? {} : { backgroundImage: `url(${props.image_path})` };
    let spinner = props.spinner === true ? <Spinner /> : null;

    return (
            <div className="rc-image" style={imgStyle}>
                {spinner}
            </div>
    )
}

export default RcSquareImage