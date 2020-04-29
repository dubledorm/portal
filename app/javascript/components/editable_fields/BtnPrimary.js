import React from "react"
import SimpleButton from "./SimpleButton";


function BtnPrimary(props) {
    return (
        <SimpleButton onClickHandler={props.onClickHandler} className='btn btn-primary'>{props.children}</SimpleButton>
    )
}

export default BtnPrimary
