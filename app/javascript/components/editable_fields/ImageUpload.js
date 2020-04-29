import React from "react"
import PropTypes from "prop-types"
import Avatar from "./Avatar";


class ImageUpload extends React.Component {
    constructor(props) {
        super(props);
        this.state = {file: '',
            imagePreviewUrl: this.props.imagePreviewUrl
        };
    }


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


    render() {

        return (
            <div>
                <Avatar image_path={this.state.imagePreviewUrl}/>
                <form>
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

