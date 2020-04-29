import React from "react"


function Avatar(props) {
    let imgStyle = {
        backgroundImage: `url(${props.image_path})`
    };
    return (
        <div className="rc-avatar-image" style={imgStyle} />
    )
}

export default Avatar
