<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/template/header.jsp" %>

<style>
    .card {
        border-radius: 0.5rem;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .post {
        padding: 1rem;
        background-color: white;
        border-radius: 8px;
    }

    .post-header {
        display: flex;
        align-items: center;
        position: relative;
        gap: 1rem;
    }

    .post-header p {
        margin: 0;
    }

    .post-header > .dropdown {
        margin-left: auto;
    }

    .post-header .open-menu {
        font-size: 1.5rem;
        width: 36px;
        height: 36px;
        border: none;
        background-color: unset;
        text-align: center;
        border-radius: 50%;
        cursor: pointer;
    }

    .post-header .open-menu:hover {
        background-color: rgba(0, 0, 0, 0.1);
    }

    .post-profile-picture {
        background-size: cover;
        background-position: center;
        width: 40px;
        height: 40px;
        border-radius: 50%;
    }

    .post-header .post-owner {
        font-weight: 500;
    }

    .post-header .post-time {
        user-select: none;
        font-size: 0.85rem;
        opacity: 0.5;
    }

    .post-body {
        padding-bottom: 1rem;
    }

    .post-body > .post-content {
        padding-top: 1rem;
        white-space: pre-wrap;
        word-break: break-word;
    }

    .post-body > textarea[name=content] {
        outline: none;
        border: none;
        resize: none;
        width: 100%;
        height: fit-content;
        padding-top: 1rem;
        display: flex;
        flex-direction: column;
    }

    .post-body > textarea[name=content]::placeholder {
        opacity: 0.5;
    }

    .post-footer {
        padding: 1rem 1rem 0;
        display: flex;
        justify-content: flex-end;
        border-top: 1px solid rgb(216, 220, 240);
        align-items: center;
    }

    .post:not(#create-post) > .post-footer {
        padding-top: 0.5rem;
    }

    .post-footer p {
        margin: 0;
        padding-left: 0.5rem;
    }

    .post-footer button  {
        font-weight: 500;
        text-transform: capitalize;
    }

    .no-bg-btn {
        color: #1e88e5;
        box-shadow: none !important;
        margin-right: 1rem;
        border-radius: unset;
    }

    #add-resource {
        border-right: 1px solid rgb(216, 220, 240);
    }

    .image-box {
        margin-top: 1rem;
        position: relative;
        width: 100%;
        height: 0;
        padding-top: 60%;
    }

    .image-box > div {
        display: flex;
        position: absolute;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        border-radius: 8px;
        overflow: hidden;
    }

    .image-box .image-column {
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    .image-box .image-item {
        width: 100%;
        flex-grow: 1;
        background-size: cover;
        background-position: center;
        cursor: pointer;
    }

    .image-box .image-more {
        content: "+2";
        color: white;
        font-size: 4rem;
        font-weight: 500;
        position: absolute;
        width: 50%;
        height: 50%;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.6);
        justify-content: center;
        align-items: center;
        display: none;
        cursor: pointer;
    }

    .image-box.more .image-more {
        display: flex;
    }

    .document-box {
        margin-top: 1rem;
        border-radius: 8px;
        overflow: hidden;
        border: 2px solid rgb(216, 220, 240);
    }

    .document-item {
        font-weight: 500;
        cursor: pointer;
        padding: 0.5rem 1rem;
        border-top: 1px solid rgb(216, 220, 240);
        position: relative;
        display: flex;
        justify-content: space-between;
    }

    .document-item > i {
        font-size: 1.5rem;
        padding: 0 0.3rem;
    }

    .document-item:hover {
        background-color: aliceblue;
    }

    .document-item:first-child {
        border: none;
    }

    .comment-item {
        padding-top: 0.5rem;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .comment-item > .comment-input {
        flex-grow: 1;
        border-radius: 20px;
        padding: 6px 1rem;
        outline: none;
        border: 2px solid #bdbdbd;
    }

    .comment-item > .comment-input::placeholder {
        opacity: 0.5;
    }

    .comment-item > .comment-input:focus {
        border: 2px solid #3b71ca;
    }

    #image-carousel {
        width: 100%;
        height: 200px;
        overflow-x: scroll;
        overflow-y: hidden;
        padding-top: 1rem;
        padding-bottom: 8px;
    }

    #image-carousel::-webkit-scrollbar {
        height: 8px;
    }

    #image-carousel::-webkit-scrollbar-thumb {
        background-color: #bbb;
        border-radius: 4px;
    }

    #image-carousel:hover::-webkit-scrollbar-thumb {
        background-color: #aaa;
    }

    #image-carousel::-webkit-scrollbar-track {
        background-color: #eee;
        border-radius: 4px;
    }

    #carousel-wrapper {
        height: 100%;
        display: flex;
        gap: 0.5rem;
    }

    .carousel-img-item {
        height: 100%;
        position: relative;
    }

    .carousel-img-item img {
        border-radius: 8px;
        height: 100%;
        user-select: none;
        cursor: pointer;
    }

    .carousel-img-item i {
        font-size: 2rem;
        position: absolute;
        top: 0;
        right: 0;
        padding: 0.5rem;
        width: 48px;
        height: 48px;
        text-align: center;
        color: white;
        filter: drop-shadow(0 0 3px black);
        border-top-right-radius: 8px;
        border-bottom-left-radius: 16px;
        cursor: pointer;
    }

    .carousel-img-item i:hover {
        background-color: rgba(0, 0, 0, 0.4);
    }

    .dropdown-item {
        cursor: pointer;
    }

    .modal-dialog {
        max-width: unset;
        background-color: white;
    }

    #new-post-modal .modal-dialog {
        padding: 1rem;
        width: 60vw;
    }

    .resource-list-wrapper {
        height: 40vh;
        overflow-y: scroll;
        margin-right: -0.5rem;
        padding-right: 0.5rem;
        position: relative
    }

    .resource-list-wrapper::-webkit-scrollbar {
        width: 8px;
    }

    .resource-list-wrapper::-webkit-scrollbar-thumb {
        background-color: #ccc;
        border-radius: 4px;
    }

    .resource-list-wrapper::-webkit-scrollbar-thumb:hover {
        background-color: #aaa;
    }

    .resource-list-wrapper > .resource-loading {
        position: absolute;
        top: 50%;
        left: 50%;
        font-size: 6rem;
        transform: translate(-50%, -50%);
    }

    #resource-list {
        position: relative;
        display: grid;
        grid-template-columns: repeat(6, minmax(0, 1fr));
        gap: 0.5rem;
    }

    .resource-item {
        cursor: pointer;
    }

    .resource-item > div {
        width: 100%;
        height: 0;
        padding-top: 100%;
        position: relative;
    }

    .resource-item > div > .loading-icon {
        position: absolute;
        width: 80%;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 0.9rem;
        display: none;
        text-align: center;
    }

    .resource-item.loading > div > .loading-icon {
        display: block;
    }

    .resource-item img {
        position: absolute;
        top: 50%;
        left: 50%;
        max-width: 100%;
        max-height: 100%;
        transform: translate(-50%, -50%);
        border-radius: 4px;
        border: 0 solid #0d6efd;
        transition: border linear 0.1s;
    }

    .resource-item.selected img {
        border-width: 3px;
    }

    .resource-item .order {
        display: block;
        opacity: 0;
        pointer-events: none;
        position: absolute;
        top: 0;
        right: 0;
        background-color: white;
        border: 3px solid #0d6efd;
        padding: 0 5px;
        margin: 4px;
        color: #0d6efd;
        min-width: 30px;
        text-align: center;
        font-weight: 800;
        border-top-left-radius: 99px;
        border-top-right-radius: 99px;
        border-bottom-left-radius: 99px;
        border-bottom-right-radius: 99px;
    }

    .resource-item.selected .order {
        opacity: 1;
    }

    .resource-item > .resource-name {
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow-x: hidden;
        text-align: center;
        font-size: 0.8rem;
    }

    .resource-item.selected > .resource-name {
        font-weight: 500;
        color: #0d6efdp;
    }

    #new-post-modal .post-footer {
        justify-content: space-between;
    }
</style>
<div class="content main-container d-flex" style="background-color: rgba(209, 209, 209, 0.5);  margin-top: 56px;">
    <%@include file="/template/sidebar.jsp" %>
    <div class="content-main  d-flex justify-content-center container position-relative">
        <div class="modal fade" id="new-post-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-content">
                <div class="resource-list-wrapper">
                    <div id="resource-list"></div>
                    <div class="resource-loading">
                        <i class="fas fa-spinner fa-spin"></i>
                    </div>
                </div>
                <div class="post-footer">
                    <div class="btn-group me-2">
                        <button class="btn btn-outline-secondary upload-btn">Upload image, video, document...</button>
                        <button class="btn btn-outline-secondary delete-btn">Detele</button>
                    </div>
                    <button data-mdb-dismiss="modal" class="btn btn-primary main-btn">Close</button>
                </div>
            </div>
        </div>
        <div class="col-md-7 mt-4 post" id="create-post">
            <div class="post-header">
                <div class="post-profile-picture" style="background-image: url(https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg)"></div>
                <div>
                    <p class="post-owner">
                        Maggi Buckberry
                    </p>
                </div>
            </div>
            <div class="post-body">
                <textarea placeholder="Enter post content here" rows="3" name="content"></textarea>
                <div id="post-image-slot"></div>
            </div>
            <div class="post-footer">
                <button id="add-resource" class="btn main-btn no-bg-btn" data-mdb-target="#new-post-modal" data-mdb-toggle="modal">Add image, video, document...</button>
                <button id="post-btn" class="btn btn-primary">Post</button>
            </div>
        </div>
        <div id="post-list" class="col-md-7">
            <div class="mt-4 post">
                <div class="post-header dropdown">
                    <div class="post-profile-picture" style="background-image: url(https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg)"></div>
                    <div>
                        <p class="post-owner">Maggi Buckberry</p>
                        <p class="post-time">Class Code: FQQBS</p>
                    </div>
                    <div class="dropdown">
                        <button class="open-menu" data-mdb-toggle="dropdown" aria-expanded="false">
                            <i class="fa-solid fa-ellipsis"></i>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li class="d-flex dropdown-item">
                                <span class="p-2 flex-shrink-1 bd-highlight">
                                    <i class="far fa-user"></i>
                                </span>
                                <span class="p-2 w-100 bd-highlight" style="color: #6e6e6e;">
                                    Profile
                                </span>
                            </li>
                            <li class="d-flex dropdown-item">
                                <span class="p-2 flex-shrink-1 bd-highlight">
                                    <i class="far fa-user"></i>
                                </span>
                                <span class="p-2 w-100 bd-highlight" style="color: #6e6e6e;">
                                    Profile
                                </span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="post-body">
                    <div class="image-box more">
                        <div>
                            <div class="image-more">+5</div>
                            <div class="image-column">
                                <div class="image-item" style="background-image: url(https://images.unsplash.com/photo-1604998103924-89e012e5265a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFuc2NhcGV8ZW58MHx8MHx8&w=1000&q=80);"></div>
                                <div class="image-item" style="background-image: url(https://images.unsplash.com/photo-1604998103924-89e012e5265a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bGFuc2NhcGV8ZW58MHx8MHx8&w=1000&q=80);"></div>
                            </div>
                            <div class="image-column">
                                <div class="image-item" style="background-image: url(https://c4.wallpaperflare.com/wallpaper/997/891/658/photography-nature-landscape-lake-wallpaper-preview.jpg);"></div>
                                <div class="image-item" style="background-image: url(https://w0.peakpx.com/wallpaper/1009/8/HD-wallpaper-golden-sunset-sunset-river-lanscape.jpg);"></div>
                            </div>
                        </div>
                    </div>
                    <div class="document-box">
                        <div class="document-item">Slot 11-Assemblies .NET.pptx</div>
                        <div class="document-item">Assignment2_MusicStoreWin.docx</div>
                        <div class="document-item">Guides_MVC.rar</div>
                    </div>
                </div>
                <div class="post-footer">
                    <i class="fa-regular fa-comment"></i>
                    <p>12 comments</p>
                </div>
                <div class="post-comment">
                    <div class="comment-item">
                        <div class="post-profile-picture" style="background-image: url(https://c4.wallpaperflare.com/wallpaper/997/891/658/photography-nature-landscape-lake-wallpaper-preview.jpg);"></div>
                        <input class="comment-input" placeholder="Enter your comment here" type="text">
                    </div>
                    <div class="comment-list">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="/template/notificationbar.jsp" %>
</div>
<script>
    const createPostInput = document.querySelector("#create-post textarea[name=content]")
    createPostInput.onfocus = () => {
        createPostInput.onfocus = null
        const initHeight = createPostInput.scrollHeight
        createPostInput.addEventListener('input', () => {
            createPostInput.style.height = '0'
            if (createPostInput.scrollHeight > initHeight) {
                createPostInput.style.height = createPostInput.scrollHeight + 'px'
            } else {
                createPostInput.style.height = initHeight + 'px'
            }
        })
    }

    const addResourceBtn = document.getElementById('add-resource')
    const postBtn = document.getElementById('post-btn')
    const postImageSlot = document.getElementById('post-image-slot')
    const createPostBody = document.querySelector("#create-post > div.post-body")

    function createElement(element) {
        const parent = document.createElement(element.tagName)
        mergeObject(element, parent)
        if (Array.isArray(element.children))
            element.children.forEach(child => parent.append(createElement(child)))
        return parent
    }

    function mergeObject(source, target) {
        Object.entries(source).forEach(attr => {
            if (attr[0] === 'children' || attr[0] === 'tagName')
                return
            if (attr[0] === 'bind') {
                attr[1][0][attr[1][1]] = target
            }
            if (Object.prototype.toString.call(attr[1]) === '[object Object]') {
                mergeObject(attr[1], target[attr[0]])
            } else if (Array.isArray(attr[1]) && typeof target[attr[0]] === 'function') {
                target[attr[0]](...attr[1])
            } else {
                target[attr[0]] = attr[1]
            }
        })
    }

    const rasterType = [
        'image/png',
        'image/jpeg',
        'image/bmp',
        'image/gif',
        'image/tiff',
        'image/webp',
        'image/avif'
    ]
    const postList = document.getElementById('post-list')

    function addPost(post) {
        const bindList = {}
        const postElement = createElement({
            tagName: 'div',
            className: 'mt-4 post',
            children: [
                {
                    tagName: 'div',
                    className: 'post-header',
                    children: [
                        {
                            tagName: 'div',
                            className: 'post-profile-picture',
                            style: 'background-image: url(https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg)'
                        },
                        {
                            tagName: 'div',
                            children: [
                                {
                                    tagName: 'p',
                                    className: 'post-owner',
                                    textContent: 'Example name'
                                },
                                {
                                    tagName: 'p',
                                    className: 'post-time',
                                    textContent: 'Example time'
                                }
                            ]
                        },
                        {
                            tagName: 'div',
                            className: 'dropdown',
                            children: [
                                {
                                    tagName: 'button',
                                    className: 'open-menu',
                                    children: [{
                                            tagName: 'i',
                                            className: 'fa-solid fa-ellipsis'
                                        }]
                                },
                                {
                                    tagName: 'ul',
                                    classname: 'dropdown-menu dropdown-menu-end',
                                    style: 'position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(0px, 38px);'
                                }
                            ]
                        }
                    ]
                },
                {
                    tagName: 'div',
                    className: 'post-body',
                    bind: [bindList, 'postBody'],
                    children: [
                        {
                            tagName: 'p',
                            className: 'post-content',
                            textContent: post.content
                        },
                        {
                            tagName: 'div',
                            className: 'image-box',
                            bind: [bindList, 'imageBox'],
                            children: [{
                                    tagName: 'div',
                                    bind: [bindList, 'imageList'],
                                    children: [
                                        {
                                            tagName: 'div',
                                            className: 'image-more',
                                            bind: [bindList, 'extraCount']
                                        }
                                    ]
                                }]
                        }
                    ]
                },
                {
                    tagName: 'div',
                    className: 'post-footer',
                    children: [
                        {
                            tagName: 'i',
                            className: 'fa-regular fa-comment'
                        },
                        {
                            tagName: 'p',
                            bind: [bindList, 'commentNumber'],
                            textContent: '0 comment'
                        }
                    ]
                },
                {
                    tagName: 'div',
                    className: 'post-comment',
                    children: [
                        {
                            tagName: 'div',
                            className: 'comment-item',
                            children: [
                                {
                                    tagName: 'div',
                                    className: 'post-profile-picture',
                                    style: 'background-image: url(https://c4.wallpaperflare.com/wallpaper/997/891/658/photography-nature-landscape-lake-wallpaper-preview.jpg);'
                                },
                                {
                                    tagName: 'input',
                                    className: 'comment-input',
                                    placeholder: 'Enter your comment here'
                                }
                            ]
                        },
                        {
                            tagName: 'div',
                            className: 'comment-list'
                        }
                    ]
                }
            ]
        });

        const imageL = []
        const otherL = []
        post.resources.forEach(r => {
            if (r.thumbnail) {
                imageL.push(r)
            } else {
                otherL.push(r)
            }
        })
        if (imageL.length == 0)
            bindList.imageBox.remove()
        else {
            let ePos = 0
            for (let i = 0; i < Math.min(2, imageL.length); i++) {
                const imageColumn = createElement({
                    tagName: 'div',
                    className: 'image-column'
                })
                const end = ePos + Math.ceil(Math.min(4, imageL.length - ePos + i) / 2)
                for (ePos; ePos < end; ePos++) {
                    imageColumn.append(createElement({
                        tagName: 'div',
                        className: 'image-item',
                        style: 'background-image: url("<c:url value="/"/>' + imageL[ePos].url.substring(1) + '")'
                    }))
                }
                bindList.imageList.append(imageColumn)
            }
            if (imageL.length > 4) {
                bindList.imageBox.classList.add('more')
                bindList.extraCount.textContent = '+' + (imageL.length - 4)
            }
        }
        if (otherL.length > 0) {
            const documentBox = createElement({
                tagName: 'div',
                className: 'document-box'
            })
            otherL.forEach(d => {
                documentBox.append(createElement({
                    tagName: 'div',
                    className: 'document-item',
                    textContent: d.url.split('/').pop()
                }))
            })
            bindList.postBody.append(documentBox)
        }
        postList.insertBefore(postElement, postList.children[0])
    }

    generalWS.on('new-post', newPost => addPost(newPost))

    const newfeedPosts = JSON.parse('${postObject}')
    newfeedPosts.forEach(post => addPost(post))

    const imageCarousel = createElement({
        tagName: 'div',
        id: 'image-carousel'
    })
    const carouselWrapper = createElement({
        tagName: 'div',
        id: 'carousel-wrapper'
    })
    imageCarousel.append(carouselWrapper)

    const documentBox = createElement({
        tagName: 'div',
        classList: {
            add: ['document-box']
        }
    })

    function removeImage(element) {
        imageList = imageList.filter(img => img.element !== element)
        element.remove()
        if (imageList.length === 0) {
            imageCarousel.remove()
        }
    }

    function removeOther(element) {
        others = others.filter(f => f.element !== element)
        element.remove()
        if (others.length === 0) {
            documentBox.remove()
        }
    }

    const uploadBtn = document.querySelector('#new-post-modal .upload-btn')
    uploadBtn.disabled = true
    const deleteBtn = document.querySelector('#new-post-modal .delete-btn')
    deleteBtn.disabled = true
    const resourceList = document.getElementById('resource-list')
    const allResources = []
    const selectedResources = []
    const xhrQueue = []
    let requesting = false

    function setSelectable(resource) {
        resource.element.addEventListener('click', () => {
            if (!resource.selected) {
                selectedResources.push(resource)
                resource.order.textContent = selectedResources.length
                resource.element.classList.add('selected')
                resource.selected = true
                if (!resource.preview) {
                    if (rasterType.includes(resource.mimeType)) {
                        resource.preview = createElement({
                            tagName: 'div',
                            classList: {
                                add: ['carousel-img-item']
                            },
                            children: [
                                {
                                    tagName: 'img',
                                    draggable: false,
                                    src: '<c:url value="/"/>' + resource.url.substring(1)
                                },
                                {
                                    tagName: 'i',
                                    onclick: () => resource.element.click(),
                                    classList: {
                                        add: ['fa-solid', 'fa-xmark']
                                    }
                                }
                            ]
                        })
                    } else {
                        resource.preview = createElement({
                            tagName: 'div',
                            classList: {
                                add: ['document-item']
                            },
                            textContent: resource.url.split('/').pop(),
                            onclick: null,
                            children: [{
                                    tagName: 'i',
                                    onclick: () => resource.element.click(),
                                    classList: {
                                        add: ['fa-solid', 'fa-xmark']
                                    }
                                }]
                        })
                    }
                }
                if (rasterType.includes(resource.mimeType)) {
                    carouselWrapper.append(resource.preview)
                    if (!imageCarousel.isConnected)
                        postImageSlot.append(imageCarousel);
                } else {
                    documentBox.append(resource.preview)
                    if (!documentBox.isConnected)
                        createPostBody.append(documentBox)
                }
            } else {
                const index = selectedResources.indexOf(resource)
                selectedResources.splice(index, 1)
                resource.element.classList.remove('selected')
                resource.selected = false
                selectedResources.forEach((r, i) => {
                    r.order.textContent = i + 1
                })
                resource.preview.remove()
                if (carouselWrapper.children.length == 0) {
                    imageCarousel.remove()
                }
                if (documentBox.children.length == 0) {
                    documentBox.remove()
                }
            }
        })
    }

    addResourceBtn.onclick = async () => {
        addResourceBtn.onclick = null
        const response = await fetch('<c:url value="/resource"/>')
        const json = await response.json()
        json.forEach(r => {
            let thumbnail = '<c:url value="/assets/img/default-thumb.png"/>'
            if (r.thumbnail)
                thumbnail = '<c:url value="/"/>' + r.thumbnail.substring(1)

            const resourceElement = createElement({
                tagName: 'div',
                className: 'resource-item',
                children: [
                    {
                        tagName: 'div',
                        children: [
                            {
                                tagName: 'img',
                                src: thumbnail
                            },
                            {
                                tagName: 'p',
                                className: 'order',
                                textContent: '0'
                            }
                        ]
                    },
                    {
                        tagName: 'p',
                        className: 'resource-name',
                        textContent: r.url.split('/').pop()
                    }
                ]
            })
            const rs = {
                element: resourceElement,
                order: resourceElement.querySelector('.order'),
                ...r
            }
            allResources.push(rs)
            setSelectable(rs)
            resourceList.append(resourceElement)
        })
        document.querySelector('.resource-list-wrapper > .resource-loading').remove()
        uploadBtn.disabled = false
        deleteBtn.disabled = false
    }

    uploadBtn.addEventListener('click', async () => {
        const inputElement = document.createElement('input')
        const rasterType = [
            'image/png',
            'image/jpeg',
            'image/bmp',
            'image/gif',
            'image/tiff',
            'image/webp',
            'image/avif'
        ]
        inputElement.type = 'file'
        inputElement.multiple = true
        inputElement.addEventListener('change', () => {
            [...inputElement.files].forEach(async file => {
                const formData = new FormData();
                formData.append('file', file)

                const resourceElement = createElement({
                    tagName: 'div',
                    className: 'resource-item',
                    children: [
                        {
                            tagName: 'div',
                            children: [
                                {
                                    tagName: 'img'
                                },
                                {
                                    tagName: 'p',
                                    className: 'order',
                                    textContent: '0'
                                },
                                {
                                    tagName: 'div',
                                    className: 'loading-icon',
                                    children: [
                                        {
                                            tagName: 'span'
                                        },
                                        {
                                            tagName: 'div',
                                            className: 'progress',
                                            children: [{
                                                    tagName: 'div',
                                                    className: 'progress-bar progress-bar-striped progress-bar-animated',
                                                    style: 'width: 0;'
                                                }]
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            tagName: 'p',
                            className: 'resource-name'
                        }
                    ]
                })
                const imgElement = resourceElement.querySelector('img')
                const resourceName = resourceElement.querySelector('.resource-name')
                const selectedOrder = resourceElement.querySelector('.order')
                const loadingIcon = resourceElement.querySelector('.loading-icon')
                const progressPercent = resourceElement.querySelector('span')
                const progressBar = resourceElement.querySelector('.progress-bar')

                resourceName.textContent = file.name

                const xhr = new XMLHttpRequest()
                xhr.open('POST', '<c:url value="/files"/>', true)

                xhr.upload.addEventListener('progress', e => {
                    console.log(e)
                    const percent = Math.round(e.loaded * 100 / e.total) + '%'
                    progressPercent.textContent = percent
                    progressBar.style.width = percent
                })

                xhr.upload.addEventListener('loadstart', e => {
                    console.log('START UPLOAD', file.name)
                    resourceElement.classList.add('loading')
                    resourceList.append(resourceElement)
                })

                xhr.upload.addEventListener('loadend', e => {
                    console.log('END UPLOAD', file.name, xhr.readyState)
                    resourceElement.classList.remove('loading')
                    loadingIcon.remove()
                    if (xhrQueue.length !== 0) {
                        xhrQueue.shift().start()
                    } else {
                        requesting = false
                    }
                })

                xhr.addEventListener('load', e => {
                    const json = JSON.parse(xhr.responseText)
                    console.log(json)

                    const rs = {
                        element: resourceElement,
                        order: selectedOrder,
                        ...json
                    }
                    allResources.push(rs)

                    if (json.thumbnail)
                        imgElement.src = '<c:url value="/"/>' + json.thumbnail.substring(1)
                    else
                        imgElement.src = '<c:url value="/assets/img/default-thumb.png"/>'
                    setSelectable(rs)
                })

                xhr.start = () => {
                    xhr.send(formData)
                }

                xhrQueue.push(xhr)
                if (!requesting) {
                    requesting = true
                    xhrQueue.shift().start()
                }
            })
        })
        inputElement.click()
    })

    postBtn.addEventListener('click', async () => {
        if (createPostInput.value.trim() === '' && selectedResources.length === 0)
            return
        const rsList = selectedResources.map(rs => rs.resourceId)
        const formData = new FormData()
        formData.append('classId', classId)
        formData.append('content', createPostInput.value.trim())
        formData.append('resources', JSON.stringify(rsList))
        const response = await fetch('<c:url value="/${account.role == 1 ? 'teacher' : 'student'}/class/post"/>', {
            method: 'POST',
            body: formData
        })
        if (response.ok) {
            createPostInput.value = ''
            selectedResources.forEach(r => {
                r.element.classList.remove('selected')
                r.selected = false
                r.preview.remove()
            })
            selectedResources.length = 0
            imageCarousel.remove()
            documentBox.remove()
        }
    })
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js" integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<c:import url="/template/footer.jsp" />