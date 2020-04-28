import React from "react"
import PropTypes from "prop-types"
import Avatar from "./Avatar";


class ImageUpload extends React.Component {
    constructor(props) {
        super(props);
        this.state = {file: '',
            imagePreviewUrl: this.props.imagePreviewUrl
        };
        // this.onSubmitSuccess = this.onSubmitSuccess.bind(this);
        // this.onSubmitError = this.onSubmitError.bind(this);
    }

    // _handleSubmit(e) {
    //     e.preventDefault();
    //     // TODO: do something with -> this.state.file
    //     console.log('handle uploading-', this.state.file);
    //
    //     let fd = new FormData;
    //
    //     fd.append('user[avatar]', this.state.file);
    //
    //
    //     $.ajax({
    //         type: "PUT",
    //         url: 'profile',
    //         dataType: "json",
    //         processData: false,
    //         contentType: false,
    //         data: fd,
    //         success: this.onSubmitSuccess,
    //         error: this.onSubmitError
    //     });
    // }

    _handleImageChange(e) {
        e.preventDefault();

        let reader = new FileReader();
        let file = e.target.files[0];

        reader.onloadend = () => {
            this.setState({
                file: file,
                imagePreviewUrl: reader.result
            });
            this.props.onSelectFileHandler(file);
        };

        reader.readAsDataURL(file)
    }

    // onSubmitSuccess(){
    //     console.log('Submit success');
    // }
    //
    // onSubmitError(error){
    //     let message = JSON.parse(error.responseText)
    //     console.error('Submit error. Message: ');
    //    // this.setState({ error_message: this.props.field_name in message ? message[this.props.field_name] : message});
    // }

    render() {
        // let {imagePreviewUrl} = this.state;
        // let $imagePreview = null;
        // if (imagePreviewUrl) {
        //     $imagePreview = (<img src={imagePreviewUrl} />);
        // } else {
        //     $imagePreview = (<div className="previewText">Please select an Image for Preview</div>);
        // }

        return (
            <div>
                <Avatar image_path={this.state.imagePreviewUrl}/>
                <form onSubmit={(e)=>this._handleSubmit(e)}>
                    <input className="rc-file-input"
                           type="file"
                           onChange={(e)=>this._handleImageChange(e)} />
                </form>
            </div>
        )
    }
}

ImageUpload.propTypes = {
    imagePreviewUrl: PropTypes.string,
    onSelectFileHandler: PropTypes.func
};

export default ImageUpload

{/*<div className="previewComponent">*/}
{/*    <form onSubmit={(e)=>this._handleSubmit(e)}>*/}
{/*        <input className="fileInput"*/}
{/*               type="file"*/}
{/*               onChange={(e)=>this._handleImageChange(e)} />*/}
{/*        <button className="submitButton"*/}
{/*                type="submit"*/}
{/*                onClick={(e)=>this._handleSubmit(e)}>Upload Image</button>*/}
{/*    </form>*/}
{/*    <div className="imgPreview">*/}
{/*        {$imagePreview}*/}
{/*    </div>*/}
{/*</div>*/}
