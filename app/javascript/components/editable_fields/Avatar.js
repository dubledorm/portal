import React from "react"
import Spinner from "./Spinner";


function Avatar(props) {
    let imgStyle = {
        backgroundImage: `url(${props.image_path})`
    };

    let spinner = props.spinner === true ? <Spinner /> : null;

    return (
        <div className="rc-avatar-image" style={imgStyle}>
            {spinner}
        </div>
    )
}

export default Avatar
