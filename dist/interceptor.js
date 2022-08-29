/*=====================================
 * Interceptor 1.0.0
 * 
 * (c) 2022 - Bruno Migliaretti
 ======================================*/

(function (win, doc) {

    class WatchList {
        constructor(list = []){
            this.list = list;
        };
        list = [];

        get length() {
            return this.list.length;
        }

        item(i) {
            return this.list[i];
        }

        add(name, action) {
            let i = this.indexOf(name);
            if (i == -1)
                this.list.push({name: name, action: action});
            else
                this.list[i].action = action;
            return (i === -1);
        }
        remove(name) {
            let i = this.indexOf(name);
            if(i > -1) {
                this.list.splice(i,1);
            };
            return (i > -1);
        }

        indexOf(name) {
            for (var i = 0; i < this.list.length; i++) {
                let entry = this.list[i];
                if(entry.name === name)
                    return i;
            }
            return -1;
        }

        getAction(name) {
            let i = this.indexOf(name);
            if(i > -1)
                return this.list[i].action;
            return null;
        }

        clear() {
            this.list.splice(0, this.list.length);
        }
    }

    class Interceptor {
        constructor(watchList, threshold = [0,1], rootMargin = '0px 0px 0px 0px') {
            this.watchList = new WatchList();

            this.threshold = threshold;
            this.rootMargin = rootMargin;
            const self = this;
            
            if (!win.IntersectionObserver) {
                this.noObserver();
                return;
            }
            this.observer = new IntersectionObserver(entries => {
                entries.forEach(entry => {
                    const target = entry.target;
                    const name = target.dataset.interceptor;
                    const action = self.getAction(name);
                    const ratio = entry.intersectionRatio;
                    if (typeof action === 'function')
                        action(target, ratio);
                    else if (ratio === 0)
                        target.classList.remove(action);
                    else if (ratio >= self.maxRatio)
                        target.classList.add(action);
                });
            }, { rootMargin: this.rootMargin, threshold: this.threshold });

            this.initObservation(watchList);
        };

        watchList = [];
        threshold = 0;
        rootMargin = '0px 0px 0px 0px';
        observer = null;

        get maxRatio() {
            if(typeof this.threshold === 'number')
                return this.threshold;
            let max = 0;
            for (let i = 0; i < this.threshold.length; i++) {
                const element = this.threshold[i];
                if(element > max)
                    max = element;
            }
            return max;
        }

        initObservation(list) {
            const self = this;
            for (let i = 0; i < list.length; i++) {
                const obj = list[i];
                self.observe(obj.name, obj.action);
            }
        }

        getAction(interceptorName) {
            return this.watchList.getAction(interceptorName);
        }

        noObserver() {
            const self = this;
            for (let index = 0; index < this.watchList.length; index++) {
                const obj = this.watchList.item(index);

            }
        };

        observe (name, action) {
            const self = this;
            const isNew = this.watchList.add(name, action);
            if (isNew) {
                const selector = `[data-interceptor="${name}"]`;
                const targetList = doc.querySelectorAll(selector);
                targetList.forEach(element => {
                    self.observer.observe(element);
                })
            }
        }

        disconnect() {
            this.watchList.clear();
            this.observer.disconnect();
        };

        takeRecords() {
            return this.observer.takeRecords();
        }

        unobserve(name) {
            const self = this;
            if (this.watchList.remove(name)) {
                const selector = `[data-interceptor="${name}"]`;
                const targetList = doc.querySelectorAll(selector);
                targetList.forEach(element => {
                    self.observer.unobserve(element);
                })
            }
        }
    }
    win.Interceptor = Interceptor;
})(window, document);